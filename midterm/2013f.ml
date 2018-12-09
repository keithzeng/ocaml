#use "helper.ml"

(*Problem 1*)
let count l x = failwith "not implemented"

let make_palyndrome l = failwith "not implemented"

(*Problem 2*)
let fold_2 f b l = failwith "not implemented"

let rec ith l i d = failwith "not implemented"

(*Problem 3*)
let k1 x = x + 1
let k2 x = x * 2
let k3 x = x + 3
let t = Node(Leaf k1, Node(Leaf k2, Leaf k3))

let rec apply_all t x = failwith "not implemented"

(*Input your answer to the right*)
let b1 x = failwith "not implemented"
let b2 x = failwith "not implemented"
let b3 x = failwith "not implemented"

let f1 = (+) 1;;
let f2 = (-) 2;;
let f3 = (+) 3;;
let f4 = (-) 9;;


let t1 = Node(Leaf f1, Leaf f2)
let t2 = Node(Leaf f3, Leaf f4)

let rec compose t1 t2 =
  match (t1, t2) with
  | _ -> failwith "not implemented"

(*Remove below after implement compose*)
let lf1 x = x
let rf1 x = x
(*Uncomment below after implement compose
let t3 = compose t1 t2
let Node(Leaf lf1, Leaf rf1) = t3
*)
let lf2 x = f1(f3 x)
let rf2 x = f2(f4 x)
