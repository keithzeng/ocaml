#use "helper.ml"

(*Problem 1*)
let first f l =
  let base = None in
  let fold_fn acc elmt =
  match acc, f elmt with
  | None, true -> Some elmt
  | _ -> acc in
  List.fold_left fold_fn base l

(*return the type maybe*)
let first1 x = Some 4
let first2 x = None
let first3 x = Some 4
let first4 x = None
let first5 x = Some 1
let first6 x = None
let first7 x = Some 3


(*Problem 2*)
let rec zip l1 l2 =
  match (l1, l2) with
  | [], _ -> []
  | _, [] -> []
  | h1::t1, h2::t2 -> (h1,h2)::(zip t1 t2)

let map2 f l1 l2 = map (fun (a,b) -> f a b) (zip l1 l2)


let map3 f l1 l2 l3 = map (fun (a,(b,c)) -> f a b c) (zip l1 (zip l2 l3))


(*Problem 3*)
let rec unzip l = 
  match l with
  | [] -> ([],[])
  | (a,b)::t -> let (left,right) = unzip t in
    (a::left,b::right)
