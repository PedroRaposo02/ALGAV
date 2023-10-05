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
menor([], 0).
menor([X], X).
menor([X|T], M) :-
    menor(T, M1),
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
    menor(List, M),
    select(M, List, Rest),
    Result = [M|Rest].


/*
    2.
        Teste o predicado de concatenação de duas listas dado nas aulas TP com
    várias alternativas de funcionamento (listas dos 2 primeiros argumentos
    instanciadas e lista do terceiro argumento não instanciada; listas dos 2
    primeiros argumentos não instanciadas e lista do terceiro argumento
    instanciada; etc). 
*/

concatena([ ],L,L).
concatena([A|B],C,[A|D]):-concatena(B,C,D).

/* Clausula de teste: 
    concatena([a,b],[c,d,e],L).
    L = [a,b,c,d,e]

    concatena(L1,L2,[a,b,c]).
    L1 = [] ,
    L2 = [a,b,c] ; 

    L1 = [a] ,
    L2 = [b,c] ;
    
    L1 = [a,b] ,
    L2 = [c] ;
    
    L1 = [a,b,c] ,
    L2 = [] ;
*/

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
    4.
         Teste o predicado que apaga a ocorrência de um dado elemento numa
    lista dado na aula TP (eliminar todas as ocorrências; eliminar só a
    primeira ocorrência; eliminar só a última ocorrência). 

*/

apaga(_,[ ],[ ]).
apaga(X,[X|L],M):-!,apaga(X,L,M).
apaga(X,[Y|L],[Y|M]):-apaga(X,L,M).

/*
    Clausula de teste:
        apaga(1,[1,2,1,3,1,4],L).
        L = [2,3,4] ;
        L = [2,3,1,4] ;
        L = [2,1,3,4] ;
        L = [2,1,3,1,4] ;
        L = [1,2,3,4] ;
        L = [1,2,3,1,4] ;
        L = [1,2,1,3,4] ;
        L = [1,2,1,3,1,4] ;
        false

    Caso nao tenha o !, caso tenho apenas retorna a solucao L = [2, 3, 4];
*/

/*
    5. 
        Escreva um predicado que substitua todas as ocorrências de um
        elemento numa lista por outro elemento.
*/

substitui(A, B, List, L) :-
    substituiAux(A, B, List, [], L1),
    inverte(L, L1).

substituiAux(_, _, [], L, L).
substituiAux(A, B, [H|T], L, R) :-
    (
        A = H -> substituiAux(A, B, T, [B|L], R)
        ;
        substituiAux(A, B, T, [H|L], R)
    ).

/* Clausula de teste:
    substitui(1, 2, [1,2,3,4,5,1,2,3,4,5], L).
    L = [2,2,3,4,5,2,2,3,4,5]
*/

/*
    6. 
        Escreva um predicado que insira uma dado elemento numa posição de
    uma lista

*/

insere(X, 0, T, H, R):-
    T1 = [X|T],
    inverte(H, H1),
    concatena(H1, T1, R).
insere(X, P, [Y|T], H, R) :-
    P1 is P - 1,
    insere(X, P1, T, [Y|H], R).

insere(X, _, [], [X]).    
insere(X, 0, L, [X|L]).  
insere(X, P, L, R):- insere(X, P, L, [], R).   


/*
    Clausula de teste:
    insere(x,3,[a,b,a,c,a,d],L).
    L=[a,b,x,a,c,a,d]
    true 
*/

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
    8. 
        Teste o predicado de interseção de dois conjuntos representados por
    listas dado na aula TP
*/

intersecao([ ],_,[ ]).
intersecao([X|L1],L2,[X|LI]):-member(X,L2),!,intersecao(L1,L2,LI).
intersecao([_|L1],L2, LI):- intersecao(L1,L2,LI).

/*
    Clausula de teste:
        intersecao([1,2,3,4],[1,3,5,7],L).
        L = [1,3]
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
    uniao(Result1, Result2, Result).

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
    10.
        Implemente um predicado que linearize uma lista, ou seja, numa lista
    cujos elementos podem ser atómicos ou outras listas devolver a lista com 
    tods os átomos da lista original.
*/

flatten([],[]).
flatten(X,[X]).
flatten([X|L],LF):- 
    flatten(X,L1),
    flatten(L,L2),
    append(L1,L2,LF).

/*
    Clausula de teste:
        flatten([[a,b,c],[d,[e,f],g],h],L).
        L = [a,b,c,d,e,f,g,h] 
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

/*
    12.
        Implemente um predicado que obtenha uma permutação de uma lista.
    Verifique que esse predicado tenha a capacidade de obter todas as
    permutações de elementos da lista.
*/

permutacao([], []).
permutacao([H|Perm], List) :-
    select(H, List, Rest),
    permutacao(Perm, Rest).

/*
    Quantas permutaçãoes sao possiveis?
        Reposta: n! 
*/

/*
    Clausula de teste:
        permutacao([a,b,c,d,e],L).
        L=[a,b,c,d,e];
        L=[a,b,c,e,d];
        L=[a,b,d,c,e];
        L=[a,b,d,e,c];
        …
        L=[e,d,c,b,a] 
*/
