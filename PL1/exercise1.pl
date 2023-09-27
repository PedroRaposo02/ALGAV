% Continent
continente(africa).
continente(america).
continente(asia).
continente(europa).
continente(oceania).

% Paises
pais(alemania,europa,82000).
pais(argentina,america,43000).
pais(bolivia,america,11000).
pais(brasil,america,85000).
pais(canada,america,100000).
pais(chile,america,18000).
pais(spain,europa,50000).
pais(france,europa,67000).
pais(italy,europa,61000).
pais(portugal,europa,9200).
pais(russia,asia,170000).
pais(portugal,europa,9200).

% Fronteiras
fronteira(argentina,brasil).
fronteira(argentina,bolivia).
fronteira(argentina,chile).
fronteira(bolivia,brasil).
fronteira(bolivia,chile).
fronteira(portugal,spain).
fronteira(spain,france).
fronteira(france,italy).


vizinhos(P1, P2) :- fronteira(P1,P2) ; fronteira(P2,P1).
contSemPaises(C) :- continente(C) , not(pais(_,C,_)).
semVizinhos(L) :- pais(L,_,_) , not(vizinhos(L,_)).
chegoLaFacil(P1,P2) :- (vizinhos(P1, P2) ; (vizinhos(P1, X) , vizinhos(X, P2))) , not(P1=P2).

% 4

pot(_,0,1).
pot(X,Y,R):-
    Y1 is Y - 1,
    pot(X,Y1,Rp),
    R is X * Rp.

fat(0,1).
fat(1,1).
fat(X,R) :-
    X1 is X - 1,
    fat(X1, Rp),
    R is X * Rp.

sum(J,J,J).
sum(J,K,R) :-
    K < J, sum(K, J, R);
    write(J ),
    write(K ),
    J1 is J + 1,
    sum(J1, K, Rp),
    R is J + Rp.

divNoRecursive(A, B, Q, R) :-
    Q is A // B,
    R is A mod B.

divRecursive(A, A, 1, 0).
divRecursive(A, B, Q, R) :- 
    B > A, R is A;
    A1 is A - B,
    Q1 is Q + 1,
    divRecursive(A1, B, Q1, R).

