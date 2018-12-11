zip([],[],[]).
zip(_,[],[]) :- fail.
zip([],_,[]) :- fail.
zip([X|T1],[Y|T2],[[X,Y]|R]) :- zip(T1,T2,R).


part([],_,[],[]).
part([X|T],P,[X|L],R) :- X=<P, part(T,P,L,R).
part([X|T],P,L,[X|R]) :- X>P, part(T,P,L,R).

qsort([],[]).
qsort([X],[X]).
qsort([X|T],L3) :- part(T,X,R1,R2),qsort(R1,L1),qsort(R2,L2),!,append(L1,[X|L2],L3).