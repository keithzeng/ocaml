#use "helper.ml"

(*Problem 1*)
let count l x =
  let base = 0 in
  let fn acc y = if y = x then acc + 1 else acc in
  fold_left fn base l

let make_palyndrome l =
  let base = l in
  let fn acc x = x::acc in
  fold_left fn base l

(*Problem 2*)
let fold_2 f b l =
  let base = (0,b) in
  let fn acc x = let (id,a) = acc in
    (id+1,f a x id) 
  in
  let (_,res) = fold_left fn base l in
  res


let rec ith l i d =
  let f dflt elmt id = if id = i then elmt else dflt in
  fold_2 f d l

(*Problem 3*)
let k1 x = x + 1
let k2 x = x * 2
let k3 x = x + 3
let t = Node(Leaf k1, Node(Leaf k2, Leaf k3))

let rec apply_all t x =
  match t with
  | Leaf f -> f x
  | Node(l, r) -> apply_all r (apply_all l x)

(*Input your answer to the right*)
let b1 x = 4
let b2 x = "a123bab"
let b3 x = [24;16;8]

let f1 = (+) 1;;
let f2 = (-) 2;;
let f3 = (+) 3;;
let f4 = (-) 9;;


let t1 = Node(Leaf f1, Leaf f2)
let t2 = Node(Leaf f3, Leaf f4)

let rec compose t1 t2 =
  match (t1, t2) with
  | Leaf l, Leaf r -> Leaf (fun x -> l (r x))
  | Node(l1,r1), Node(l2,r2) -> Node(compose l1 l2, compose r1 r2)
  | _ -> t1

let t3 = compose t1 t2
let Node(Leaf lf1, Leaf rf1) = t3
let t4 = Node(Leaf(fun x -> f1(f3 x)),Leaf(fun x -> f2(f4 x)))
let Node(Leaf lf2, Leaf rf2) = t4


