printlist([]).
printlist([X|List]) :-
    write(X), nl,
    printlist(List).

insertAtEnd(X, [], [X]).
insertAtEnd(X, [H|T], [H|Z]) :- insertAtEnd(X, T, Z).  

path(A,B,R) :-
	(
		A==B,
		R='Yes'
	);
	R='Yes',
	walk(A,B,[],R);
	R='No'.

walk(A,B,V,R) :-
	connect(A,X),
	not(member(X,V)),
	(
		B == X;
		walk(X,B,[A|V],R)
	).

setRelation(N) :-
	N > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),
	assert(connect(A, B)),
	assert(connect(B, A)),
	setRelation(N-1);
	true.

getRelation(T, L, S1, S2) :-
	T > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),
	path(A,B,R),
	insertAtEnd(R, S1, S2),
	getRelation(T-1, L, S2, _S3);
	printlist(S1).

main :-	
	readln(N),
	nth0(0, N, A), nth0(1, N, B),
	setRelation(B),

	readln(T),
	getRelation(T, A, _S1, _S2),

	halt.

:- initialization(main).