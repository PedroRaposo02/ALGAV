/*
    1. 
        Implemente os predicados para realizar as seguintes tarefas: 
*/


/* a) Obter a média de uma lista de inteiros */

mediaLista([], 0).
mediaLista([X], X).
mediaLista([H|T], M) :-
    mediaListaAux(T, TO, C),
    C1 is C + 1,
    TO1 is TO + H,
    M is TO1 / C1.

mediaListaAux([X], X, 1).
mediaListaAux([H|T], TO, C) :-
    mediaListaAux(T, TO1, C1),
    C is C1 + 1,
    TO is TO1 + H.


/* b) Obter o menor valor de uma lista de inteiros */
menorValorLista([], 0).
menorValorLista([X], X).
menorValorLista([X|T], M) :-
    menorValorLista(T, M1),
    (
        X < M1 -> M is X
        ;
        M is M1
    ).

/* c) Contar o número de elementos pares e ímpares numa lista de inteiros */
contarPares([], 0, 0).
contarPares([X], 1, 0) :- isPar(X).
contarPares([X], 0, 1) :- not(isPar(X)).
contarPares([X|T], P, I) :-
    contarPares(T, P1, I1),
    (
        isPar(X) -> P is P1 + 1, I is I1
        ;
        P is P1, I is I1 + 1
    ).

isPar(X) :- 
(
    X mod 2 =:= 0 -> true
    ;
    false
).

/* d) Colocar o menor elemento da lista à frente da lista */
colocarMenorNaFrente(List, Result) :-
    menorValorLista(List, M),
    select(M, List, Rest),
    Result = [M|Rest].



/*
    3. 
        Teste o predicado inversão de uma lista dado nas aulas TP.
*/

inverte(L,LI):-inverte1(L,[ ],LI).
inverte1([ ],L,L).
inverte1([X|L],L2,L3):- 
    inverte1(L,[X|L2],L3).

/* Clausula de teste: 
    inverte([5,4,3,2,1], L).
    L = [1,2,3,4,5]
*/


/*
    5. 
        Escreva um predicado que substitua todas as ocorrências de um
        elemento numa lista por outro elemento.
*/

substitui(A,B, List, L) :-
    substituiAux(A, B, List, [], L1),
    inverte(L, L1).

substituiAux(_, _, [], L, L).
substituiAux(A, B, [A|T], L, R) :-
    substituiAux(A, B, T, [B|L], R).
substituiAux(A, B, [H|T], L, R) :-
    A \= H,
    substituiAux(A, B, T, [H|L], R).


/*
    7. 
        Teste o predicado de união de dois conjuntos representados por listas
        (os conjuntos não admitem elementos repetidos) dado na aula TP
*/

uniao([ ],L,L).
uniao([X|L1],L2,LU):-
    member(X,L2),
    !,
    uniao(L1,L2,LU).
uniao([X|L1],L2,[X|LU]):-
    uniao(L1,L2,LU).


/* Clausula de teste:
    união([1,2,3,4],[1,3,5,7],L).
    L = [2,4,1,3,5,7]
*/



/*
    9. 
        Implemente um predicado que efetue a diferença entre dois conjuntos
        representados por listas, ou seja, gera um conjunto com os elementos
        que pertencem a um dos dois conjuntos, mas não a ambos
*/

pertenceApenasUm(List1, List2, Result) :-
    pertenceApenasUmAux(List1, List2, Result1),
    pertenceApenasUmAux(List2, List1, Result2),
    uniao(Result1, Result2, Union),
    append(Union, [], Result).

pertenceApenasUmAux([], _, []).
pertenceApenasUmAux([X|T], List, Result) :-
    (
        member(X, List) -> Result = Rest
        ;
        Result = [X|Rest]
    ),
    pertenceApenasUmAux(T, List, Rest).



/* Clausula de teste:
    pertenceApenasUm([1,2,3,4],[1,3,5,7],L).
    L = [2,4,5,7]
*/

/*
    11.
        Implemente um predicado que obtenha uma combinação de N
        elementos de uma lista com N ou mais elementos. Verifique se o
        predicado tem a capacidade de gerar todas as combinações possíveis.
        Quantas são essas combinações?
*/

combinacao(0, _, []).
combinacao(N, [X|T], [X|Comb]) :-
    N > 0,
    N1 is N - 1,
    combinacao(N1, T, Comb).
combinacao(N, [_|T], Comb) :-
    N > 0,
    combinacao(N, T, Comb).

/* Clausula de teste:
    combinacao(6,[a,b,c,d,e,f,g,h],L).
    L=[a,b,c,d,e,f];
    L=[a,b,c,d,e,g];
    L=[a,b,c,d,e,h];
    L=[a,b,c,d,f,g];
    L=[a,b,c,d,f,h];
    …
    L=[c,d,e,f,g,h]
*/