let length = List.length

let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0

let implode cs = 
  String.concat "" (List.map (String.make 1) cs)


let map = List.map


let incr x = x+1
let decr x = x-1

let even x = (x mod 2 = 0)

type 'a maybe = 
  | None
  | Some of 'a


let add a b c = a + b + c

let f a b c = (a = b + c)