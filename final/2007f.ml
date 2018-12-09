(*Problem 1*)
(*a*)
let ans1 x = 100
(*b*)
let ans2 x = (101,1001)
(*d, error*)
let ans3 x = [(1,"a");(2,"b")]
(*d*)
let ans =
  let foo x =
    match x with
    | 0 -> Bool true 
    | -1 -> Bool false 
    |_ -> Int x in
  foo 12

let ans4 x = Int 12
(*e*)
let ans =
  let f g = fun x -> g (g x) in 
  let h= f f (fun x->x*10) in
  h 1
let ans5 x = 10000


(*Problem 2*)
(*a*)
type mix = Int of int | Bool of bool
let ans x =
  match x with
  | -2 -> Bool false
  | -1 -> Bool true
  |_ ->Int x
let ans1 x = "int -> mix"

(*b*)
let ans f g x =
     if f x then x else g x
let ans2 x = "('a -> bool) -> ('a -> 'a) -> 'a -> 'a"

(*c*)
let rec ans n f x =
     if n <= 0 then x else ans (n-1) f (f x)
let ans3 x = "int -> ('a -> 'a) -> 'a -> 'a"

(*d*)
let ans b f g = (fun x -> (if b then f else g) x)
let ans4 x = "bool -> ('a -> 'b) -> ('a -> 'b) -> 'a -> 'b"

(*e*)
let rec ans x ys =
  match ys with
  | [] -> x
  | y::ys' -> ans (y x) ys'
let ans5 x = "'a -> ('a -> 'a) list -> 'a"


(*Problem 3*)
(*a*)
let rec fac x =
  let rec helper x acc =
    if x <= 1 then acc
    else helper (x-1) acc*x
  in
  helper x 1
(*b*)
let rec map f xs = 
  let rec helper l acc =
    match l with
    | [] -> acc
    | h::t -> helper t (acc@[f h])
  in
  helper xs []

let rec map f xs = 
  let rec helper l acc =
    match l with
    | [] -> List.rev acc
    | h::t -> helper t ((f h)::acc)
  in
  helper xs []
(*c*)
let rec foldr f xs b =
match xs with
[] -> b
| x::xs' -> f x (foldr f xs' b)

let rec foldr2 f xs b =
  let rec helper l acc =
    match l with
    | [] -> acc
    | h::t -> helper t (f h acc)
  in
  helper (List.rev xs) b

foldr (fun a -> fun b -> b@[a]) [1;2;3] []

(*Problem 4*)
type ty = Tyint | Tybool | Tyfun of ty * ty
(*a*)
let a = Tyfun (Tyfun (Tyint, Tyint), Tyint)
(*b*)
let rec lookup tenv x = 
  match tenv with
  | [] -> None
  | (xi,ti)::t -> if xi = x then Some ti
                  else lookup t x
(*c*)
type binop = Plus | Minus | Eq | Leq | And | Or
type expr =
| Const of int
| Var of string
| Bin of expr * binop * expr
| If of expr * expr * expr
| Let of string * expr * expr
| App of expr * expr
| Fun of string * ty * expr

Let("x",Const(10),Let("y",Bin(Var("x"),Plus,Const(12)),Bin(Var("x"),Plus,Var("y")))) 

let rec check env e =
match e with
| Const i -> Some Tyint
| Var x -> lookup env x
| Bin (e1,Plus,e2) | Bin (e1,Minus,e2) ->
  let t1 = check env e1 in
  let t2 = check env e2 in
  if t1 = t2 && t1 = Some Tyint then t1 else None
| Bin (e1,Leq,e2) | Bin (e1,Eq,e2) ->
  let t1 = check env e1 in
  let t2 = check env e2 in
  if t1 = t2 then t1 else None
| Bin (e1,And,e2) | Bin (e1,Or,e2) ->
  let t1 = check env e1 in
  let t2 = check env e2 in
  if t1 = t2 && t1 = Some Tybool then t1 else None
| App (e1,e2) ->
  let t1 = check env e1 in
  let t2 = check env e2 in
  (match (t1,t2) with None,_ | _,None -> None
    | Some Tyfun(t3,t4),Some t5 -> if not(t3=t5) then None else Some t4
    | Some t3, _ -> Some t3
  )
| Fun (x,t,e) ->
  (match (check ((x,t)::env) e) with None -> None
  | Some t1 -> Some t1)
| Let (x,e1,e2) ->
  (match check env e1 with None -> None
  | Some t1 -> check ((x,t1)::env) e2)
| If (p,t,f) ->
  let tp = check env p in
  let tt = check env t in
  let tf = check env f in
  if tp=Some Tybool && tt = tf  then tt
  else None

check [("x",Tyint);("y",Tyfun(Tyint,Tyint));("x",Tybool)] (Var "y")
check [("x",Tyint);("y",Tyfun(Tyint,Tyint));("x",Tybool)] (Bin(Var "x",Plus,Const 2))
check [("x",Tyint);("y",Tyfun(Tyint,Tyint));("x",Tybool)] (Bin (Var "x",Plus,Var "y"))
check [("z",Tyint)] (App (Fun("x",Tyint,Bin(Var "x",Plus,Const 10)), Var "z"))



