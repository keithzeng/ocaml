(*Problem 1*)
(*a*)
type 'a dict = Empty | Node of string * 'a * 'a dict * 'a dict

let fruitd =
Node ("grape", 2.65,
Node ("banana", 1.50,
Node ("apple", 2.25, Empty, Empty),
Node ("cherry", 2.75, Empty, Empty)),
Node ("orange", 0.75,
Node ("kiwi", 3.99, Empty, Empty),
Node ("peach", 1.99, Empty, Empty)))

let rec find d k =
  match d with
  | Empty -> raise Not_found
  | Node (k', v', l, r) ->
    if k = k' then v'
    else if k < k' then find l k
    else find r k

let rec add d k v =
  match d with
  | Empty -> Node(k,v,Empty,Empty)
  | Node(k',v',l,r) ->
    if k = k' then Node(k,v,l,r)
    else if k < k' then Node(k',v',add l k v,r)
    else Node(k',v',l,add r k v)

let rec fold f b d =
  match d with
  | Empty -> b
  | Node(k,v,l,r) -> fold f (f k v (fold f b l)) r

fold (fun k v b -> b +. v) 0. fruitd
fold (fun k v b -> b^","^k) "" fruitd


(*2*)
type name_space = EmptyNameSpace | Info of (string * value) list * name_space and value = Int of int | Method of (name_space -> int -> int)



let method_f self i = i+1
let simpleObj1 = Info([("a", Int(0)); ("f", Method(method_f))], EmptyNameSpace)
let method_g self i = i+2
let simpleObj2 = Info([("g", Method(method_g))], simpleObj1)

(*a*)
let rec helper l s =
  match l with
  | [] -> None
  | (k,v)::t -> if k = s then Some v else helper t s

let rec lookup ns s =
  match ns with
  | EmptyNameSpace -> raise Not_found
  | Info(l,pns) -> (
    match helper l s with
    | None -> lookup pns s
    | Some v -> v
  )

lookup simpleObj2 "a"
lookup simpleObj2 "midori"

(*b*)
exception TypeError
let to_int value =
  match value with
  | Int(i) -> i
  | _ -> raise TypeError



let to_method value =
  match value with
  | Method(m) -> m
  |_ -> raise TypeError

let method_f self i = (to_int (lookup self "a")) + i
let obj3 = Info([("a", Int(10)); ("f", Method(method_f))], EmptyNameSpace)

(*c*)
let invoke_method self name i = (to_method (lookup self name)) self i
invoke_method obj3 "f" 3











