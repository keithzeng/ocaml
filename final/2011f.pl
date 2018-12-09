sat(var(X)) :- X = 1.
sat(not(var(X))) :- X = 0.

sat(and([])).
sat(and([X|Tail])) :- sat(X), sat(and(Tail)).

sat(or([])) :- fail.
sat(or([X|_])) :- sat(X).
sat(or([_|Tail])) :- sat(or(Tail)).

bool(X) :- X = 0.
bool(X) :- X = 1.
bools([]).
bools([X|Tail]) :- bool(X),bools(Tail).

allsat(E, F) :- bools(E),sat(F).