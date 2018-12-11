#use "helper.ml"

(*Problem 1*)
let length l = 
  let base = 0 in
  let fn a x = a + 1 in
  fold_left fn base l

let remove l x =
  let base = [] in
  let fn acc e = if e = x then acc else acc@[e] in
  fold_left fn base l

(*Problem 2*)
let rec ith  l i d =
  match l with
  | [] -> d
  | h::t -> if i = 0 then h else ith t (i - 1) d

let rec update l i n =
  match l with
  | [] -> []
  | h::t -> if i = 0 then n::t else h::(update t (i-1) n)

let rec update2 l i n d =
  match l with
  | [] -> if i = 0 then [n] else d::(update2 l (i-1) n d)
  (*| [] -> update2 [d] i n d*)
  | h::t -> if i = 0 then n::t else h::(update2 t (i-1) n d)

(*Problem 3*)
let f i = if i < 0 then 0
		  else (if i < 10 then 1
		       else (if i < 20 then 2 else 3))

let categorize f l = 
  let base = [] in
  let fold_fn acc elmt =
    let id = f elmt in
  	let a = ith acc id [] in
  	update2 acc id (a@[elmt]) []
  in
  List.fold_left fold_fn base l

