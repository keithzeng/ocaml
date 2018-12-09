%4
%a
sorted([]).
sorted([_]).
sorted([X,Y|T]) :- X =< Y, sorted([Y|T]).


%b
delete(X,[X|T],T).
delete(X,[H|T],[H|NT]):-delete(X,T,NT).
permutation([], []).
permutation(L, [H|P]) :- delete(H,L,R), permutation(R,P).

sort2(L1,L2) :- permutation(L1,L2), sorted(L2),!.

%c
split([], [], []).
split([X], [X], []).
split([X|T],[X|L],R) :- split(T,R,L),!.

%d
merge([],L,L).
merge(L,[],L).
merge([H1|T1],[H2|T2],[H1|L]) :- H1=<H2, merge(T1,[H2|T2],L).
merge([H1|T1],[H2|T2],[H2|L]) :- H1>H2, merge([H1|T1],T2,L).

%e
merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(L,S) :- split(L,P1,P2), merge_sort(P1,R1), merge_sort(P2,R2), merge(R1,R2,S),!.