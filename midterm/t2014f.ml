#use "2014f.ml"

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
      runTest (rename_var (Op("+",Var"a",Const 4)) "a", "b",(Op("+",Var"b",Const 4)),3,"rename_var 1");
      runTest (rename_var (Op("+",Var"a",Const 4)) "b", "c",(Op("+",Var"a",Const 4)),3,"rename_var 2");
      runTest (rename_var (Op("+",Op("*",Var"x",Var"y"),Op("-",Var"x",Var"z"))) "x", "y",Op("+",Op("*",Var"y",Var"y"),Op("-",Var"y",Var"z")),4,"rename_var 3");
      runTest (to_str, (Op("+",Var"a",Const 4)),"a+4",3,"to_str 1");
      runTest (to_str, (Op("+",Const 10,Op("+",Const 10,Var"b"))),"10+(10+b)",3,"to_str 2");
      runTest (to_str, (Op("+",Op("*",Var"x",Var"y"),Op("-",Var"x",Var"z"))),"(x*y)+(x-z)",4,"to_str 3");
      runTest (average_if even,[1;2;3;4;5],3,6,"average_if 1");
      runTest (average_if even,[1;2;3;4;5;6;7;8],5,6,"average_if 2");
      runTest (average_if even,[1;3;5;7],0,8,"average_if 3");
      runTest (length_2,[[1;2;3];[4;6]],5,1,"length_2 1");
      runTest (length_2,[[1;2;3];[4;6];[9;10]],7,2,"length_2 2");
      runTest (length_2,[[];[];[]],0,2,"length_2 3");
      runTest (length_3,[[[1;2;3]];[[4;6];[7;8]]],7,2,"length_3 1");
      runTest (length_3,[[[1;2;3]];[[4;6];[7;8];[10;11]]],9,3,"length_3 2");
      runTest (ans1,0,f1 [1;2;3;4],1,"ans1");
      runTest (ans2,0,f2 [3;5;7;9],1,"ans2");
      runTest (ans3,0,f3 [1;3;6],1,"ans3");
      runTest (ans4,0,0,2,"ans4");
      runTest (ans5,0,"yyyzzzabc",2,"ans5");
      runTest (ans6,0,[24;18;12],3,"ans6");
      ] in
    let s = Printf.sprintf "Results: Score/Max = %d / %d \n" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)

let _ = runAllTests ()

let _ = print130 ("Compiled"^key^"\n")
