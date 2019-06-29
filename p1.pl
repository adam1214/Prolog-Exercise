is_prime(2).
is_prime(3).
is_prime(P) :- 
    integer(P),     %P要是整數
    P > 3,          %P要大於3
    P mod 2 =\= 0,  %P除以二餘數要不等於0
    not(has_factor(P,3)). 

% has_factor(N,L) :- N has a factor F >= L.

has_factor(N,L) :- N mod L =:= 0.
has_factor(N,L) :- L + 1 < N, L2 is L + 1, has_factor(N,L2).

goldbach(4,[2,2]) :- write('2 2'), format("~n").
goldbach(N,L) :- N mod 2 =:= 0, N > 4, goldbach(N,L,3).

goldbach(N,[P,Q],P) :-
    Q is N - P, 
    is_prime(Q), 
    is_prime(P),
    format("~d ~d ~n",[P,Q]),
    D is N div 2, 
    P > D.
goldbach(N,L,P) :-  
    P < N, 
    next_prime(P,P1), 
    D is N div 2, 
    (P1 < D ->
        goldbach(N,L,P1)
    ;
        halt
    ).

next_prime(P,P1) :- P1 is P + 1, is_prime(P1).
next_prime(P,P1) :- P2 is P + 1, next_prime(P2,P1).


main :-
    write('Input: '),
    read(N),
    write('Output: '),
    format("~n"),
    goldbach(N,_L),

    halt.

:- initialization(main).
