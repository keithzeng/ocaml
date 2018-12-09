(*Problem 1*)
(*a*)
let ans1 x = 804
(*b*)
let ans2 x = "type error"
(*c*)
let ans3 x = 100
(*d*)
let ans4 x = 20

(*Problem 2*)
let rec ru (f,g,base) =
  if (g base) then ru (f,g,(f base))
  else base

(*a*)
let recru x = "('a -> 'a) * ('a -> bool) * 'a -> 'a"

(*b*)
let reverse l =
  let f (h::t,r) = (t,h::r) in
  let g (n,r) = if n = [] then false else true in
  let base = (l,[]) in
  let (_,r) = ru (f,g,base) in
  r

(*Problem 2*)
(*a*)
let ans1 x = true
let ans2 x = true
let ans3 x = false


(*Problem 5*)
(*a*)
type boolexp =
  | Var of int
  | Not of boolexp
  | Or of boolexp*boolexp
  | And of boolexp*boolexp

let expression x0 x1 x2 x3 = And(Or(Var x0,Not(Var x1)),Or(Var x1,Not(Var x2)))

let ith l i = 
  match l with
  | [] -> false
  | h::t -> if i = 0 then h else ith t (i-1)

let rec eval l e =
  match e with
  | Var i -> ith l i
  | Not e -> not (eval l e) 
  | And (e1,e2) -> (eval l e1) && (eval l e2)
  | Or (e1,e2) -> (eval l e1) || (eval l e2)

let rec inputs n = 
  if n = 0 then [[]]
  else let l = inputs (n-1) in
  (List.map (fun x -> true::x) l)@
  (List.map (fun x -> false::x) l)