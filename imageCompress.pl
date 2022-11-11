:- module(imageCompress, [imageCompress/2]).

/*
DOMINIOS
PixelIn, PixelOut, PixelsIn, PixelsOut, ImageIn, ImageOut = Listas

REGLAS
changePosXPosY/2, changeAllPosXPosY/2, imageChange/2, imageRotate90/2.

META PRINCIPAL
imageRotate90/2.

METAS SECUNDARIAS
changePosXPosY/2, changeAllPosXPosY/2, imageChange/2.
*/


/*================================================== CODIGO ==========================================================================*/
isMember(X, [[_,_,X|_]|_]).
isMember(X, [_|T]):- isMember(X, T).

toSet(List, Set):- helper(List, [], Set).


toSetHelper([], Acc, Acc):- !.
toSetHelper([H|T], Acc, Set):- member(H, Acc), toSetHelper(T, Acc, Set), !.
toSetHelper([H|T], Acc, Set):- toSetHelper(T, [H|Acc], Set), !.

helper([], Acc, Acc):- !.
helper([[_, _, E|_]|T], Acc, Set):- isMember(E, Acc), helper(T, Acc, Set), !.
helper([H|T], Acc, Set):- helper(T, [H|Acc], Set), !.

imageCompress(Image, ImageOut):- image(_, _, Pixel, Image), toSet(Pixel, L), reverse(L, ImageOut).
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
%imageCompress(I, I1).
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1|...], [1, 1|...]]],
%I1 = [[0, 0, 0, 10], [1, 0, 1, 30]].


%pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 30, 30, 30, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
%image(2, 2,[P1, P2, P3, P4], I), imageCompress(I, I1).
%P1 = [0, 0, 10, 10, 10, 10],
%P2 = [0, 1, 30, 30, 30, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 10, 10, 10|...], [0, 1, 30, 30|...], [1, 0, 30|...], [1, 1|...]]],
%I1 = [[0, 0, 10, 10, 10, 10], [0, 1, 30, 30, 30, 20], [1, 1, 40, 40, 40, 40]].


%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FAFAFA", 20, P2), pixhex(1, 0, "FFFFFF", 30, P3), pixhex(1, 1, "FFFFFF", 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageCompress(I, I1).
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "FAFAFA", 20],
%P3 = [1, 0, "FFFFFF", 30],
%P4 = [1, 1, "FFFFFF", 40],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "FAFAFA", 20], [1, 0, "FFFFFF"|...], [1, 1|...]]],
%I1 = [[0, 0, "FFFFFF", 10], [0, 1, "FAFAFA", 20]].
/*=======================================================================================================================================*/