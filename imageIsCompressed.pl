:- module(imageIsCompressed, [imageIsCompressed/1]).

/*
DOMINIOS
N = Entero+
Pixel, Pixels, ImageI = Listas

REGLAS
myLength/2, pixelIsCompressed/1, pixelsAreCompressed/1, imageIsCompressed/1.

META PRINCIPAL
imageIsCompressed/1.

METAS SECUNDARIAS
myLength/2, pixelIsCompressed/1, pixelsAreCompressed/1.
*/

/*================================================== CODIGO ==========================================================================*/
myLength([], 0):- !.
myLength([_|T], N):- myLength(T, N1), N is N1 + 1.


pixelIsCompressed(Pixel):- pixbit(_, _, _, _, Pixel), myLength(Pixel, N), N < 4;
    pixrgb(_, _, _, _, _, _, Pixel), myLength(Pixel, N1), N1 < 6.

pixelsAreCompressed([]):- !.
pixelsAreCompressed([Pixel|Pixels]):- pixelIsCompressed(Pixel), pixelsAreCompressed(Pixels).


imageIsCompressed(Image):- image(_, _, Pixel, Image), pixelsAreCompressed(Pixel).
/*====================================================================================================================================*/

/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 1, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 0, 30, P3), pixbit(1, 1, 0, 10, P4),image(2, 2,[P1, P2, P3, P4], I), 
%imageIsCompressed(I). 
%false.

%pixhex(0, 0, "#F0F0F0", 10, P1), pixhex(0, 1, "#F0F0F0", 20, P2), pixhex(1, 0, "#F0F0F0",30, P3), pixhex(1, 1, "#F0F0F0", 10, P4),
%image(2, 2,[P1, P2, P3, P4],I), imageIsCompressed(I).
%false.

%pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 255, 255, 255, 20, P2), pixrgb(1, 0, 255, 255, 255, 30, P3), pixrgb(1, 1, 255, 255, 255, 10, P4), 
%image(2, 2,[P1, P2, P3, P4], I), imageIsCompressed(I).
%false.
/*========================================================================================================================================*/