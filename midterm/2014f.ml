#use "helper.ml"

(*Problem 1*)
let rec rename_var e n1 n2 = failwith "not implemented"

let to_str e = 
  let rec str_helper e top_level = failwith "not implemented" in
  str_helper e true

(*Problem 2*)
let average_if f l = failwith "not implemented"

(*Problem 3*)
let length_2 l = failwith "not implemented"

let length_3 l = failwith "not implemented"

(*Problem 4*)
let f1 = List.map (fun x->2*x)
let f2 = List.fold_left (fun x y->(y+2)::x) []
let f3 = List.fold_left (fun x y->x@[3*y]) []
let f = List.fold_left (fun x y -> y x)

(*Save the answer to the right*)
let ans1 x = failwith "not implemented"
let ans2 x = failwith "not implemented"
let ans3 x = failwith "not implemented"
let ans4 x = failwith "not implemented"
let ans5 x = failwith "not implemented"
let ans6 x = failwith "not implemented"