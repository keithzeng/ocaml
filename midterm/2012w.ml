#use "helper.ml"

(*Problem 1*)
let rec split l =
  let base = failwith "not implemented" in
  let fold_fn (i,l1,l2) elemt = failwith "not implemented" in
  let (_,l1,l2) = List.fold_left fold_fn base l in
  (l1,l2)


let rec merge l1 l2 =
  match (l1, l2) with
  | ([],l) -> l
  | (l,[]) -> l
  | _ -> failwith "not implemented"


let rec merge_sort l = failwith "not implemented"


(*Problem 2*)
let replace s = failwith "not implemented"


(*Problem 3*)
let app l x = failwith "not implemented"

(*let [f1;f2] = app [(=);(<)] 2*)

(*Set the function = to a boolean*)
let f11 x = failwith "not implemented"
let f12 x = failwith "not implemented"
let f13 x = failwith "not implemented"
let f21 x = failwith "not implemented"
let f22 x = failwith "not implemented"
let f23 x = failwith "not implemented"