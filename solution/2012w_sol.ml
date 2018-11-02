(*Problem 1*)
#use "helper.ml"

let rec split l =
  let base = (0,[],[]) in
  let fold_fn (i,l1,l2) elemt = (
    if i < (length l)/2 then (i+1, l1@[elemt], l2)
    else (i+1,l1,l2@[elemt])) in
  let (_,l1,l2) = List.fold_left fold_fn base l in
  (l1,l2)


let rec merge l1 l2 =
  match (l1, l2) with
  | ([],l) -> l
  | (l,[]) -> l
  | (h1::t1, h2::t2) ->
    if h1 <= h2 then h1::(merge t1 l2)
    else h2::(merge l1 t2)


let rec merge_sort l =
  match l with
  | [] -> []
  | [x] -> [x]
  | l -> let l1,l2 = split l in merge (merge_sort l1) (merge_sort l2)



let replace s = implode (map (fun x -> if x = '-' then ' ' else x) (explode s))


(*the input will be an function, so we use it and evaluate with x*)
let app l x = map (fun z -> z x) l

let [f1;f2] = app [(=);(<)] 2

let f11 x = false
let f12 x = true
let f13 x = false
let f21 x = false
let f22 x = false
let f23 x = true