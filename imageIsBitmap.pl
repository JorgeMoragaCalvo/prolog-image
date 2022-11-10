:- module(imageIsBitmap, [imageIsBitmap/1]).

/*
DOMINIOS
X, Y, Bit, Depth = Enteros+
Pixel, Pixels, Image = Listas

PREDICADOS
isnumberPositive/1, elementsArePositive/1, pixelIsBitmap/1, pixelsAreBitmap/1, imageIsBitmap/1.

META PRINCIPAL
imageIsBitmap/1.

METAS SECUNDARIAS
isnumberPositive/1, elementsArePositive/1, pixelIsBitmap/1, pixelsAreBitmap/1.
*/


/*================================================== CODIGO ==========================================================================*/
isnumberPositive(Pixel):- pixbit(X, Y, _, Depth, Pixel),
    (number(X), X >= 0),
    (number(Y), Y >= 0),
    (number(Depth), Depth >= 0), !.

elementsArePositive([]):- !.
elementsArePositive([Pixel|Pixels]):- isnumberPositive(Pixel), elementsArePositive(Pixels), !.

pixelIsBitmap(Pixel):- pixbit(_, _, Bit, _, Pixel), (Bit == 0; Bit == 1), !.

pixelsAreBitmap([]):- !.
pixelsAreBitmap([Pixel|Pixels]):- pixelIsBitmap(Pixel), pixelsAreBitmap(Pixels).

imageIsBitmap(Image):- image(_, _, Pixels, Image), pixelsAreBitmap(Pixels), 
    elementsArePositive(Pixels), !.
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I),
%imageIsBitmap(I).
%True.

%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 2, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I),
%imageIsBitmap(I).
%false. El Bit del Pixel 3, no es ni 0 ni 1.

%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(-1, 1, 0, 40, P4),image(2, 2, [P1, P2, P3, P4], I),
%imageIsBitmap(I).
%false. La coordenada X del Pixel 4 es negativa.
/*========================================================================================================================================*/