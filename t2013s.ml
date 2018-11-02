#use "2013s_sol.ml"

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
      runTest (length, [1;3;4],3,5,"length 1");
      runTest (length, [], 0, 5,"length 2");
      runTest (remove [1;2;3], 2, [1;3], 5,"remove 1");
      runTest (remove [1;2;3], 4, [1;2;3], 5,"remove 2");
      runTest (ith ["a";"b";"c";"d"] 0, "", "a", 2,"ith 1");
      runTest (ith ["a";"b";"c";"d"] 1, "", "b", 2,"ith 2");
      runTest (ith ["a";"b";"c";"d"] 2, "", "c", 2,"ith 3");
      runTest (ith ["a";"b";"c";"d"] 3, "", "d", 2,"ith 4");
      runTest (ith ["a";"b";"c";"d"] 4, "", "", 2,"ith 5");
      runTest (update ["a";"b";"c";"d"] 0, "ZZZ", ["ZZZ";"b";"c";"d"], 2,"update 1");
      runTest (update ["a";"b";"c";"d"] 1, "ZZZ", ["a";"ZZZ";"c";"d"], 2,"update 2");
      runTest (update ["a";"b";"c";"d"] 2, "ZZZ", ["a";"b";"ZZZ";"d"], 2,"update 3");
      runTest (update ["a";"b";"c";"d"] 3, "ZZZ", ["a";"b";"c";"ZZZ"], 2,"update 4");
      runTest (update ["a";"b";"c";"d"] 4, "ZZZ", ["a";"b";"c";"d"], 2,"update 5");
      runTest (update2 ["a";"b";"c";"d"] 0 "ZZZ", "", ["ZZZ";"b";"c";"d"], 1,"update2 1");
      runTest (update2 ["a";"b";"c";"d"] 1 "ZZZ", "", ["a";"ZZZ";"c";"d"], 1,"update2 2");
      runTest (update2 ["a";"b";"c";"d"] 2 "ZZZ", "", ["a";"b";"ZZZ";"d"], 1,"update2 3");
      runTest (update2 ["a";"b";"c";"d"] 3 "ZZZ", "", ["a";"b";"c";"ZZZ"], 1,"update2 4");
      runTest (update2 ["a";"b";"c";"d"] 4 "ZZZ", "", ["a";"b";"c";"d";"ZZZ"], 1,"update2 5");
      runTest (update2 ["a";"b";"c";"d"] 5 "ZZZ", "", ["a";"b";"c";"d";"";"ZZZ"], 1,"update2 6");
      runTest (update2 ["a";"b";"c";"d"] 6 "ZZZ", "", ["a";"b";"c";"d";"";"";"ZZZ"], 2,"update2 7");
      runTest (update2 ["a";"b";"c";"d"] 7 "ZZZ", "", ["a";"b";"c";"d";"";"";"";"ZZZ"], 2,"update2 8");
      runTest (categorize f, [1;2;-3;15;7;30;-1;22;33;14;105], [[-3;-1];[1;2;7];[15;14];[30;22;33;105]], 5,"categorize 1");
      runTest (categorize f, [-3;12;14], [[-3];[];[12;14]], 5,"categorize 2");
      runTest (categorize f, [], [], 5,"categorize 3");
      ] in
    let s = Printf.sprintf "Results: Score/Max = %d / %d \n" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)

let _ = runAllTests ()

let _ = print130 ("Compiled"^key^"\n")
