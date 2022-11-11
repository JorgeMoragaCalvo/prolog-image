:- module(imageToHistogram, [imageToHistogram/2]).


/*======================================= CODIGOS DE PRUEBA =====================================================================*/
pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]).
image(Width, Height, Pixels, [Width, Height, Pixels]).
pixrgb(X, Y, R,G,B, Depth, [X, Y, R,G,B, Depth]).

car([H|_], H).
cdr([_|T], T).

second(L, N):- cdr(L, L1), car(L1, N).
fourth(L, N):- cdr(L, L1), cdr(L1, L2), cdr(L2, L3), car(L3, N).
fifth(L, N):- cdr(L, L1), cdr(L1, L2), cdr(L2, L3), cdr(L3, L4), car(L4, N).

%bit(PixelIn, PixelOut):- pixbit(_,_,_,_,PixelIn), third(PixelIn, PixelOut).

elements([], []):- !.
elements([[_, _, Third, Fourth, Fifth|_]| Xs], [Third, Fourth, Fifth|Ys]):- elements(Xs, Ys).

%(bitsElement(ImageIn, L); bitsElements(ImageIn, L)), !.
/*========================================================================================================================================*/

/*
DOMINIOS
N, X, C, Third = Enteros+
ImageIn, Xs, L = Listas

REGLAS
third/2, thirdElement/2, histogramAux/3, frequency/2, bitsElement/2, bitsElements/2, imageToHistogram/2

META PRINCIPAL
imageToHistogram/2.

METAS SECUNDARIAS
third/2, thirdElement/2, histogramAux/3, frequency/2, bitsElement/2, bitsElements/2.
*/


/*================================================== CODIGO ==========================================================================*/
third(L, N):- cdr(L, L1), cdr(L1, L2), car(L2, N).


thirdElement([], []):- !.
thirdElement([[_,_,Third|_]|Xs], [Third|Ys]):- thirdElement(Xs, Ys).


histogramAux([], C:N, [C:N]).
histogramAux([X|Xs], X:N, F):- !, N1 is N+1, histogramAux(Xs, X:N1, F).
histogramAux([X|Xs], C:N, [C:N|F]):- histogramAux(Xs, X:1, F).


frequency([], []).
frequency([X|Xs], F):- histogramAux(Xs, X:1, F).

%frequency([0,0,1,2,2], L).
%L = [0:2, 1:1, 2:2].


bitsElement(ImageIn, L):- image(_, _, _, ImageIn), third(ImageIn, L1), thirdElement(L1, L2), frequency(L2, L), !.


bitsElements(ImageIn, L):- image(_, _, _, ImageIn), third(ImageIn, L1), elements(L1, L2), frequency(L2, L), !.


imageToHistogram(ImageIn, L):- ((third(ImageIn, P), car(P, P1), length(P1, N), N is 6)
    -> bitsElements(ImageIn, L); bitsElement(ImageIn, L)).
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I), 
%imageToHistogram(I, I1).
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1|...], [1, 1|...]]],
%I1 = [0:2, 1:2].


%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FFFFFF", 20, P2), pixbit(1, 0, "FFFFFF", 30, P3), pixbit(1, 1, "F0F0F0", 40, P4), 
%image(2, 2, [P1, P2, P3, P4], I), imageToHistogram(I, I1).
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "FFFFFF", 20],
%P3 = [1, 0, "FFFFFF", 30],
%P4 = [1, 1, "F0F0F0", 40],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "FFFFFF", 20], [1, 0, "FFFFFF"|...], [1, 1|...]]],
%I1 = ["FFFFFF":3, "F0F0F0":1].


%pixrgb(0, 0, 0, 0, 0, 10, P1), pixrgb(0, 1, 10, 10, 10, 20, P2),  pixrgb(1, 0, 20, 20, 20, 30, P3), pixrgb(1, 1, 30, 30, 30, 40, P4), 
%image(2, 2, [P1, P2, P3, P4], I), imageToHistogram(I, I1).
%P1 = [0, 0, 0, 0, 0, 10],
%P2 = [0, 1, 10, 10, 10, 20],
%P3 = [1, 0, 20, 20, 20, 30],
%P4 = [1, 1, 30, 30, 30, 40],
%I = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 10, 10, 10, 20], [1, 0, 20, 20, 20, 30], [1, 1, 30, 30, 30, 40]]],
%I1 = [0:3, 10:3, 20:3, 30:3].
/*========================================================================================================================================*/