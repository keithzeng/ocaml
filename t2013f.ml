#use "2013f.ml"

let key = "" (* change *)
let prefix130 = "130" (* change *)
let print130 s = print_string (prefix130^">>"^s)

exception ErrorCode of string

type result = Pass | Fail | ErrorCode of string

let score = ref 0
let max = ref 0
let timeout = 300

let runWTimeout (f,arg,out,time) = 
  try if compare (f arg) out = 0 then Pass else Fail
  with e -> (print130 ("Uncaught Exception: "^(Printexc.to_string e)); ErrorCode "exception") 

exception TestException
let testTest () =
  let testGood x = 1 in
  let testBad x = 0 in 
  let testException x = raise TestException in
  let rec testTimeout x = testTimeout x in
    runWTimeout(testGood,0,1,5) = Pass &&  
    runWTimeout(testBad,0,1,5) = Fail &&  
    runWTimeout(testException,0,1,5) = ErrorCode "exception" && 
    runWTimeout(testTimeout,0,1,5) = ErrorCode "timeout"


let runTest (f,arg,out,points,name) =
  let _ = max := !max + points in
  let outs = 
	match runWTimeout(f,arg,out,timeout) with 
	    Pass -> (score := !score + points; "[pass]")
 	  | Fail -> "[fail]"
	  | ErrorCode e -> "[error: "^e^"]"  in
  name^" "^outs^" ("^(string_of_int points)^")\n"

(* explode : string -> char list *)
let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0

let implode cs = 
  String.concat "" (List.map (String.make 1) cs)

let drop_paren s = 
  implode (List.filter (fun c -> not (List.mem c ['(';' ';')'])) (explode s))

let eq_real p (r1,r2) = 
  (r1 -. r2) < p || (r2 -. r1) < p

let runAllTests () =
    let _ = (score := 0; max := 0) in
    let report =
      [
      runTest (count [1;2;3;4;5],10,0,3,"count 1");
      runTest (count [1;2;3;4;5],3,1,3,"count 2");
      runTest (count [1;3;2;3;4;3;5],3,3,4,"count 3");
      runTest (make_palyndrome,[1;2],[2;1;1;2],3,"make_palyndrome 1");
      runTest (make_palyndrome,[1;2;3],[3;2;1;1;2;3],3,"make_palyndrome 2");
      runTest (make_palyndrome,[],[],4,"make_palyndrome 3");
      runTest (fold_2 (fun d e i-> d*e*(i+1)) 1,[3;2],12,5,"fold_2");
      runTest (fold_2 (fun d e i-> d*e*(i+1)) 1,[3;2;1],36,5,"fold_2");
      runTest (ith ["a";"b";"c";"d"] 0,"","a",2,"ith 1");
      runTest (ith ["a";"b";"c";"d"] 1,"","b",2,"ith 2");
      runTest (ith ["a";"b";"c";"d"] 2,"","c",2,"ith 3");
      runTest (ith ["a";"b";"c";"d"] 3,"","d",2,"ith 4");
      runTest (ith ["a";"b";"c";"d"] 4,"","",2,"ith 5");
      runTest (apply_all t, 0,5,10,"apply_all");
      runTest (b1, 0,apply_all (Node(Node(Leaf((+)1),Leaf((-)2)),Leaf((+)3))) 0,3,"apply_all t 0");
      runTest (b2, 0,apply_all (Node(Leaf((^)"a"),Node(Leaf(fun x->x^"b"),Leaf(fun x->x^"ab")))) "123",3,"apply_all t 123");
      runTest (b3, 0,apply_all (Node(Node(Leaf fl1,Leaf fl1),Node(Leaf fl1,Leaf fl2))) [1;2;3],4,"apply_all t [1;2;3]");
      runTest (lf1, 3,lf2 3,5,"compose");
      runTest (rf1, 3,rf2 3,5,"compose");
      ] in
    let s = Printf.sprintf "Results: Score/Max = %d / %d \n" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)

let _ = runAllTests ()

let _ = print130 ("Compiled"^key^"\n")
