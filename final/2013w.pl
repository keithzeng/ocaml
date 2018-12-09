%2
%a
remove_all(_,[],[]).
remove_all(X,[X|T],R) :- remove_all(X,T,R).
remove_all(X,[Y|T],[Y|R]) :- not(X=Y), remove_all(X,T,R).

%b
remove_first(_,[],[]).
remove_first(X,[X|T],T).
remove_first(X,[Y|T],[Y|R]) :- not(X=Y), remove_first(X,T,R).

%c
prefix([],_).
prefix([H|T],[H|R]) :- prefix(T,R).

%d
segment(L1,L2) :- prefix(L1,L2).
segment(L1, [_|L2]) :- segment(L1,L2).