#use "2013w.ml"

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
      runTest (first even, [1;3;4;5;7;9;11],Some 4,6,"first 1");
      runTest (first even, [1;2;3;4;5;7;9;10;11],Some 2,6,"first 2");
      runTest (first even, [1;3;5;7;9;11],None,6,"first 3");
      runTest (first1, 1, Some 4, 1,"first 4");
      runTest (first2, 1, None, 1,"first 5");
      runTest (first3, 1, Some 4, 1,"first 6");
      runTest (first4, 1, None, 1,"first 7");
      runTest (first5, 1, Some 1, 1,"first 8");
      runTest (first6, 1, None, 1,"first 9");
      runTest (first7, 1, Some 3, 1,"first 10");
      runTest (zip [1;2;3], [5;6;7], [(1,5);(2,6);(3,7)], 2,"zip 1");
      runTest (zip ['a';'b';'c'], [1;2;3], [('a',1);('b',2);('c',3)], 3,"zip 2");
      runTest (zip ['a'], [1;2;3], [('a',1)], 2,"zip 3");
      runTest (zip ['a';'b';'c'], [1;2], [('a',1);('b',2)], 3,"zip 4");
      runTest (map2 (+) [1;2;3], [4;6;8], [5;8;11], 1,"map2 1");
      runTest (map2 (-) [1;2;3], [4;6;8], [-3;-4;-5], 1,"map2 2");
      runTest (map2 (/) [10;9;4], [2;3;4], [5;3;1], 1,"map2 3");
      runTest (map2 (+) [1;2], [4;6;8], [5;8], 2,"map2 4");
      runTest (map3 add [1;2] [3;4], [5;6], [9;12], 2,"map3 1");
      runTest (map3 add [1] [3;4], [5;6], [9], 3,"map3 2");
      runTest (unzip, [(1,2);(3,4);(5,6)], ([1;3;5],[2;4;6]), 5,"unzip 1");
      runTest (unzip, [('a',1);('b',2)], (['a';'b'],[1;2]), 5,"unzip 2");
      ] in
    let s = Printf.sprintf "Results: Score/Max = %d / %d \n" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)

let _ = runAllTests ()

let _ = print130 ("Compiled"^key^"\n")
