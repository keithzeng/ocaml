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
bacon(X,Y) :- costar(X,Y).
bacon(X,Y) :- not(X=Y), costar(X,Z), bacon(Z,Y).


%10(a)
envtype(Env,X,T) :- Env=[[X,T]|_].
envtype(Env,X,T) :- Env=[[Y,_]|R], not(Y=X), envtype(R,X,T).

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
