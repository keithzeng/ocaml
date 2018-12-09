(*Problem 1*)
(*a*)
let rec insert l i =
  match l with
  | [] -> [i]
  | h::t -> if h >= i then i::l
    else h::(insert t i)

(*b*)
let insertion_sort = List.fold_left insert []

(*Problem 2*)
(*a*)
type expr =
  | Var of string
  | Const of int
  | Plus of expr * expr

let rec simpl e =
  match e with
  | Plus (e1,e2) -> (
  	let e1' = simpl e1 in
  	let e2' = simpl e2 in
  	match (e1',e2') with
  	| Const i, Const j -> Const (i+j)
  	| _ -> Plus(e1',e2))
  | _ -> e