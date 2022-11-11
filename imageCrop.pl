:- module(imageCrop, [imageCrop/6, range/6, lengthFour/1]).

/*
DOMINIOS
X1, X2, Y1, Y2 = Enteros+
PixelIn, PixelOut, PixelsIn, PixelsOut, Image, ImageOut = Listas

REGLAS
changePosXPosY/2, changeAllPosXPosY/2, imageChange/2, imageRotate90/2.

META PRINCIPAL
imageRotate90/2.

METAS SECUNDARIAS
changePosXPosY/2, changeAllPosXPosY/2, imageChange/2.
*/


car([H|_], H).
cdr([_|T], T).
third(L, N):- cdr(L, L1), cdr(L1, L2), car(L2, N).
lengthFour(L):- third(L, N), car(N, H), length(H, N1), N1 is 4.


/*================================================== CODIGO ==========================================================================*/
range(Pixel, X1, Y1, X2, Y2, PixelOut):- (pixbit(X, Y, Bit, Depth, Pixel) ->
    (X > X1, Y > Y1, X < X2, Y < Y2, pixbit(X, Y, Bit, Depth, PixelOut));
    (pixrgb(X, Y, R, G, B, Depth, Pixel), X > X1, Y > Y1, X < X2, Y < Y2, pixrgb(X, Y, R, G, B, Depth, PixelOut))).


pixelsRange(_, _, _, _, [], []):- !.
pixelsRange(X1, Y1, X2, Y2, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- isBetween(X1, Y1, X2, Y2, PixelIn, PixelOut),
    pixelsRange(X1, Y1, X2, Y2, PixelsIn, PixelsOut), !.
pixelsRange(X1, Y1, X2, Y2, [_|PixelsIn], [_|PixelsOut]):- pixelsRange(X1, Y1, X2, Y2, PixelsIn, PixelsOut), !.


isBetween(X1, Y1, X2, Y2, PixelIn, PixelOut):- (pixbit(X, Y, Bit, Depth, PixelIn) ->
    (X > X1, Y > Y1, X < X2, Y < Y2, pixbit(X, Y, Bit, Depth, PixelOut));
    pixrgb(X, Y, R, G, B, Depth, PixelIn), X > X1, Y > Y1, X < X2, Y < Y2, pixrgb(X, Y, R, G, B, Depth, PixelIn)).


imageCrop(Image, X1, Y1, X2, Y2, ImageOut):- image(_, _, PixelsIn, Image),
    pixelsRange(X1, Y1, X2, Y2, PixelsIn, ImageOut).
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
%imageCrop(I, -1, -1,0.5, 0.5,I1).
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1|...], [1, 1|...]]],
%I1 = [[0, 0, 0, 10], _, _, _].


%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
%imageCrop(I, 0.5, 0.5, 2, 2 ,I1).
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1|...], [1, 1|...]]],
%I1 = [_, _, _, [1, 1, 1, 40]].


%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FAFAFA", 20, P2), pixhex(1, 0, "C8C8C8", 30, P3), pixhex(1, 1, "E3E3E3", 40, P4), image(2, 2,[P1, P2, P3, P4], I),
%imageCrop(I, 0.5, 0.5, 2, 2 ,I1).
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "FAFAFA", 20],
%P3 = [1, 0, "C8C8C8", 30],
%P4 = [1, 1, "E3E3E3", 40],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "FAFAFA", 20], [1, 0, "C8C8C8"|...], [1, 1|...]]],
%I1 = [_, _, _, [1, 1, "E3E3E3", 40]].
/*=======================================================================================================================================*/