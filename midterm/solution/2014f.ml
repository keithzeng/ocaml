#use "helper.ml"

(*Problem 1*)
let rec rename_var e n1 n2 =
  match e with
  | Const i -> Const i
  | Var x -> if x = n1 then Var n2 else Var x
  | Op (o,e1,e2) -> Op (o, rename_var e1 n1 n2, rename_var e2 n1 n2)

let to_str e = 
  let rec str_helper e top_level = 
  	match e with
  	| Const i -> string_of_int i
  	| Var x -> x
  	| Op(o,e1,e2) ->
  	  let left = str_helper e1 false in
  	  let right = str_helper e2 false in
  	  if top_level then left^o^right
  	  else "("^left^o^right^")"
  in
  str_helper e true

(*Problem 2*)
let average_if f l =
  let folding_fn acc x =
    let (c,s) = acc in
    if f x then (c+1,s+x)
    else (c,s)
  in
  let base = (0,0) in
  let (c,s) = List.fold_left folding_fn base l in
  if c = 0 then 0
  else s/c

(*Problem 3*)
let length_2 l = List.fold_left (+) 0 (List.map length l)

let length_3 l = List.fold_left (+) 0 (List.map length_2 l)

(*Problem 4*)
let f1 = List.map (fun x->2*x)
let f2 = List.fold_left (fun x y->(y+2)::x) []
let f3 = List.fold_left (fun x y->x@[3*y]) []
let f = List.fold_left (fun x y -> y x)

(*Save the answer to the right*)
let ans1 x = [2;4;6;8]
let ans2 x = [11;9;7;5]
let ans3 x = [3;9;18]
let ans4 x = 0
let ans5 x = "yyyzzzabc"
let ans6 x = [24;18;12]
