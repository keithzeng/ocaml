#use "2012w.ml"

let key = "" (* change *)
let prefix130 = "130" (* change *)
let print130 s = print_string (prefix130^">>"^s)

exception ErrorCode of string

type result = Pass | Fail | ErrorCode of string

let score = ref 0
let max = ref 0
let timeout = 300

(* 
exception TimeOutException
let reset_alarm () = Sys.set_signal Sys.sigalrm (Sys.Signal_ignore)
let set_alarm timeout =
  ignore (Sys.signal
            Sys.sigalrm
            (Sys.Signal_handle (fun i -> reset_alarm (); raise TimeOutException)));
  ignore (Unix.alarm timeout)

let runWTimeout (f,arg,out,time) = 
  let rv = ref (ErrorCode "timeout") in  
  set_alarm timeout;
  let rv = 
    try if compare (f arg) out = 0 then Pass else Fail
    with TimeOutException -> ErrorCode "timeout"
    | e -> 
      (print130 ("Uncaught Exception: "^(Printexc.to_string e));
       ErrorCode "exception") in
  reset_alarm ();
  rv
*)

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
      runTest (split, [23;1;8;3],([23;1],[8;3]),1,"split 1");
      runTest (split, [23;1;8;3;6],([23;1],[8;3;6]),1,"split 2");
      runTest (split, [23;1;8;3;6;20],([23;1;8],[3;6;20]),1,"split 3");
      runTest (split, ["a";"b";"c"],(["a"],["b";"c"]),1,"split 4");
      runTest (split, ["a"],([],["a"]),1,"split 5");
      runTest (merge [2;4;6;8],[1;3;5],[1;2;3;4;5;6;8],1,"merge 1");
      runTest (merge [2;10;20],[1;2;3;4;5;8;10;12],[1;2;2;3;4;5;8;10;10;12;20],1,"merge 2");
      runTest (merge_sort, [2;10;3;2;1],[1;2;2;3;10],1,"merge_sort 1");
      runTest (merge_sort, [-10;0;10;-20;100;-100],[-100;-20;-10;0;10;100],1,"merge_sort 2");
      ] in
    let s = Printf.sprintf "Results: Score/Max = %d / %d \n" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)

let _ = runAllTests ()

let _ = print130 ("Compiled"^key^"\n")
