printlist([]).
printlist([X|List]) :-
    write(X), nl,
    printlist(List).

insertAtEnd(X, [], [X]).
insertAtEnd(X, [H|T], [H|Z]) :- insertAtEnd(X, T, Z).  

commonAncestor(A, B, R) :-
	parent(A, B), %if A是B的parent
	R is A;

	parent(B, A), %else if B是A的parent
	R is B;

	parent(X, A), parent(Y, B), %else if A與B沒有共同父母,就繼續找
	X \= Y,
	commonAncestor(X, Y, R);

	parent(X, A), parent(Y, B), %else if A與B是sibling
	X == Y,
	R is Y.

	

setRelation(N) :-
	N > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),
	assert(parent(A, B)),
	setRelation(N-1);
    true.

getRelation(T, S1, S2) :-
	T > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),
	commonAncestor(A, B, R),
	insertAtEnd(R, S1, S2),
	getRelation(T-1, S2, _S3);
	printlist(S1).

main :-
	readln(N),
	setRelation(N-1),

	readln(T),
	getRelation(T, _S1, _S2),

    halt.

:- initialization(main).