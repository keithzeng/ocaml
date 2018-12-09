(*Problem 1*)
(*a*)
let rec find d k =
  match d with
  | [] -> raise Not_found
  | (k',v')::t -> 
    if k = k' then v'
    else if k > k' then find t k
    else raise Not_found

let rec add d k v =
  match d with
  | [] -> [(k,v)]
  | (k',v')::t ->
    if k' > k then (k,v)::d
    else if k' = k then (k,v)::t
    else (k',v')::(add t k v)


let keys d = List.map (fun (k,v) -> k) d

let values d = List.map (fun (k,v) -> v) d

let key_of_max_val d =
  let fn (k,v) (k',v') = if v' > v then (k',v')
    else (k,v)
  in
  match d with
  | [] -> raise Not_found
  | base::t -> let (k,_) = List.fold_left fn base t in
  k