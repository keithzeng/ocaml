(*Problem 1*)
(*a*)
let count f l = List.fold_left (fun a e -> if f e then a + 1 else a) 0 l

(*b*)
let count1 x = 1
let count2 x = 8
let count3 x = 6
let count4 x = 2
let count5 x = 4

(*c*)
let stretch l =
  let fn acc e = acc@[e;e] in
  List.fold_left fn [] l

(*Problem 2*)
type 'a tree =
| Empty
| Node of 'a * 'a tree list


let rec zip l1 l2 =
  match (l1,l2) with
  | ([],[]) -> []
  | (h1::t1, h2::t2) -> (h1,h2)::(zip t1 t2)
  | _ -> raise Not_found


let rec tree_zip t1 t2 =
  match (t1,t2) with
  | Node(a,l1), Node(b,l2) -> (
  	let l = zip l1 l2 in
  	let f (o1,o2) = tree_zip o1 o2 in
  	Node((a,b),List.map f l)
  )
  | Empty, Empty -> Empty
  | _ -> raise Not_found