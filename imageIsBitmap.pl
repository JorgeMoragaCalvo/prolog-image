:- module(imageIsBitmap, [imageIsBitmap/1]).


/*
DOMINIOS
X, Y, Bit, Depth = Enteros+
Pixel, Pixels, Image = Listas

PREDICADOS
isnumberPositive(), elementsArePositive(), pixelIsBitmap(), pixelsAreBitmap(), imageIsBitmap().

META PRINCIPAL
imageIsBitmap().

METAS SECUNDARIAS
isnumberPositive(), elementsArePositive(), pixelIsBitmap(), pixelsAreBitmap().
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


/*=============================================  SCRIPTS DE PRUEBAS  =====================================================================*/
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