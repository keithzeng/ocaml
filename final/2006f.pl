actor(xmen,jackman).
actor(xmen,berry).
actor(scoop,jackman).
actor(scoop,johanssen).
actor(lost_in_translation,murray).
actor(lost_in_translation,johanssen).
actor(ghostbusters,murray).
actor(ghostbusters,akroyd).
actor(batmanreturns,bale).
actor(batmanreturns,caine).
actor(dirtyrottenscoundrels,martin).
actor(dirtyrottenscoundrels,caine).
actor(shopgirl,danes).
actor(shopgirl,martin).

% (a)
costar(X,Y) :- actor(M,X), actor(M,Y), not(X=Y).

% (b)
busy(X,R) :- bagof(M,actor(M,X),R),length(R,L),L>1.
busy(X) :- bagof(M,actor(M,X),R),length(R,L),L>1.

% (c)
bacon(X,Y) :- helper(X,Y,[X]).
helper(X,Y,Seen) :- costar(X,Y), not(member(Y, Seen)).
helper(X,Y,Seen) :-
	costar(X,Z),
	not(member(Z,Seen)),
	helper(Z,Y,[Z|Seen]).


%10(a)
envtype(Env,X,T) :- Env=[[X,T]|_].
envtype(Env,X,T) :- not(Y=X), Env=[[Y,_]|R], envtype(R,X,T).

% (b)
typeof(_,const(_),T) :- T=int.
typeof(Env,var(X),T) :- envtype(Env,X,T).
typeof(Env,plus(E1,E2),T) :- T=int,typeof(Env,E1,int),typeof(Env,E2,int).
typeof(Env,leq(E1,E2),T) :- T=bool,typeof(Env,E1,int),typeof(Env,E2,int).
typeof(Env,ite(E1,E2,E3),T) :- typeof(Env,E1,bool),typeof(Env,E2,T), typeof(Env,E3,T).
typeof(Env,letin(var(X),E1,E2),T) :- typeof(Env,E1,T1), typeof([[X,T1]|Env],E2,T).
typeof(Env,fun(var(X),E),T) :- T=arrow(T1,T2),typeof([[X,T1]|Env],E,T2).
typeof(Env,app(E1,E2),T) :- typeof(Env,E2,T2), typeof(Env,E1,arrow(T2,T)).

% (c)
%cleartype([[X,arrow(_,_)]|T],var(X)) :- [[X,arrow(_,_)]|T].
%cleartype([[Y,_]|T],var(X)) :- not(X=Y),cleartype(T,X).
%typeof(Env,app(E1,E2),T) :- typeof(Env,E2,T2), typeof(Env,E1,arrow(T2,T)), cleartype(Env,E1).
%typeof([],letin(var(id),fun(var(x),var(x)),letin(var(y),app(var(id),leq(const(2),const(3))),app(var(id),const(1)))),T).
