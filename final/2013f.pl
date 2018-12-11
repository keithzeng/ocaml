%5
link(san_diego, seattle).
link(seattle, dallas).
link(dallas, new_york).
link(new_york, chicago).
link(new_york, seattle).
link(chicago, boston).
link(boston, san_diego).


%a
path_2(A,B) :- link(A,C), link(C,B).


%b
path_3(A,B) :- link(A,C), path_2(C,B).

%c
path_N(A,B,N) :- N=1,link(A,B).
path_N(A,B,N) :- N>1, M is N - 1, link(A,C), path_N(C,B,M).

%d
path(A, B) :- path_helper(A, B, [A]).
% In path_helper below, Seen is the cities we have see so far, so we
% can avoid cycles.
path_helper(A, B, Seen) :- link(A,B), not(member(B, Seen)).
path_helper(A, B, Seen) :- 
	link(A,C),
	not(member(C,Seen)),
	path_helper(C,B,[C|Seen]).