let length = List.length

let fold_left = List.fold_left

let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0

let implode cs = 
  String.concat "" (List.map (String.make 1) cs)

let map = List.map

let incr x = x+1
let decr x = x-1

let even x = (x mod 2 = 0)

type 'a maybe = 
  | None
  | Some of 'a

let add a b c = a + b + c

type 'a fun_tree =
  | Leaf of ('a -> 'a)
  | Node of ('a fun_tree) * ('a fun_tree)

let fl1 = List.fold_left (fun x y -> (y*2)::x) []
let fl2 = List.fold_left (fun x y -> x@[y]) []

type expr =
  | Const of int
  | Var of string
  | Op of string * expr * expr