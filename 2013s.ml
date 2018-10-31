#use "helper.ml"

(*Problem 1*)
let length l = failwith "not implemented"

let remove l x = failwith "not implemented"

(*Problem 2*)
let rec ith  l i d = failwith "not implemented"

let rec update l i n = failwith "not implemented"

let rec update2 l i n d = failwith "not implemented"

(*Problem 3*)
let f i = if i < 0 then 0
		  else (if i < 10 then 1
		       else (if i < 20 then 2 else 3))

let categorize f l = 
  let base = failwith "not implemented" in
  let fold_fn acc elmt = failwith "not implemented" in
  List.fold_left fold_fn base l

