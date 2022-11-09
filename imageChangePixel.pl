:- module(imageChangePixel, [imageChangePixel/3]).


car([H|_], H).
cdr([_|T], T).
cadr(L, N):- cdr(L, L1), car(L1, N).
caddr(L, N):- cdr(L, L1), cdr(L1, L2), car(L2, N).


getThirdElement(P, E):- caddr(P, E).


%Busca que las coordenadas coincidan devolviendo la posicion de la coincidencia.
indexOf([[X, Y|_]|_], [X, Y|_], 0):- !.
indexOf([_|T], [X, Y|_], N):- indexOf(T, [X, Y|_], N1), N is N1 + 1, !.


%Inserta un elemento en la posicion indicada
insertElement(E, 0, [_|Ls], [E|Ls]):- !.
insertElement(E, N, [X|Xs], [X|Ys] ):- N1 is N - 1, insertElement(E, N1, Xs, Ys), !.


imageChangePixel(I, PModificado, I2):- getThirdElement(I, Pixels), indexOf(Pixels, PModificado, N),
    insertElement(PModificado, N, Pixels, I3), insertElement(I3, 2, I, I2), !.


/*---------------------------------------------------------------------------------------------------------------------------------------------*/
%Modifica el pixel 2 de una imagen pixrgb
%pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
%image(2, 2, [P1,P2,P3,P4], I), pixrgb(0, 1, 54, 54, 54, 20, P2_Modificado), imageChangePixel(I, P2_Modificado, I2); true.
%P1 = [0, 0, 10, 10, 10, 10],
%P2 = [0, 1, 20, 20, 20, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 10, 10, 10, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]],
%P2_Modificado = [0, 1, 54, 54, 54, 20],
%I2 = [2, 2, [[0, 0, 10, 10, 10, 10], [0, 1, 54, 54, 54, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]].


%Modifica el pixel 4 de una imagen pixbit
%pixbit(0, 0, 1, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 0, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2, [P1, P2, P3, P4], I), 
%pixbit(1, 1, 0, 50, P4_Modificado), imageChangePixel(I, P4_Modificado, I2); true.
%P1 = [0, 0, 1, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 0, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 1, 10], [0, 1, 0, 20], [1, 0, 0, 30], [1, 1, 1, 40]]],
%P4_Modificado = [1, 1, 0, 50],
%I2 = [2, 2, [[0, 0, 1, 10], [0, 1, 0, 20], [1, 0, 0, 30], [1, 1, 0, 50]]].


%Modifica el pixel 3 de una imagen pixhex
%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "E1E1E1", 20, P2), pixhex(1, 0, "FFFFFF", 30, P3), pixhex(1, 1, 1, "FFFFFF", P4),
%image(2, 2, [P1,P2,P3,P4], I), pixhex(1, 0, "C8C8C8", 50, P3_Modificado), imageChangePixel(I, P3_Modificado, I2); true.
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "E1E1E1", 20],
%P3 = [1, 0, "FFFFFF", 30],
%P4 = [1, 1, 1, "FFFFFF"],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "E1E1E1", 20], [1, 0, "FFFFFF", 30], [1, 1, 1, "FFFFFF"]]],
%P3_Modificado = [1, 0, "C8C8C8", 50],
%I2 = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "E1E1E1", 20], [1, 0, "C8C8C8", 50], [1, 1, 1, "FFFFFF"]]].

