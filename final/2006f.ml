(*Problem 1*)
(*a*)
let ans1 x = 122
(*b*)
let ans2 x = 15
(*c*)
let ans3 x = 65536

(*Problem 2*)
(*a*)
let ans1 x = "int -> int"
let ans2 x = "(int -> 'a) -> (int -> 'a) -> int -> 'a"
let ans3 x = "(('a -> 'b) * 'a) list -> 'b list"


(*Problem 4*)
(*a*)
type 'a tree =
  | Leaf of 'a
  | Node of 'a tree * 'a tree

let rec tf f b t =
  match t with
  Leaf x -> f (b,x)
  | Node (t1,t2) -> tf f (tf f b t1) t2

let t = Node(Node(Leaf 1,Leaf 2),Node(Leaf 3,Leaf 4))

let to_list t =
  let f (a,x) = a@[x] in
  let b = [] in
  tf f b t

let size t = 
  let f (r,_) = r + 1 in
  let b = 0 in
  tf f b t

(*???????????????????ASK PROFESSOR?????????????????????*)
let rec tftr f b t = 
  let rec helper b t =
  match t with
  | Leaf x -> f (b,x)
  | Node (t1,t2) -> let b = helper b t1 in
                    helper b t2
  in
  helper b t