(*Problem 1*)
#use "helper.ml"

(*Problem 1:*)
let rec split l =
  let base =
  let fold_fn (i,l1,l2) elemt =
  let (_,l1,l2) = List.fold_left fold_fn base l in
  (l1,l2)


let rec merge l1 l2 =
  match (l1, l2) with
  | ([],l) -> l
  | (l,[]) -> l
  | 


let rec merge_sort l =


(*Problem 2*)
let replace s = implode (map (fun x -> if x = '-' then ' ' else x) (explode s))


(*Problem 3*)
let app l x = 

let [f1;f2] = app [(=);(<)] 2

let f11 x = false
let f12 x = 
let f13 x = 
let f21 x = 
let f22 x = 
let f23 x = 