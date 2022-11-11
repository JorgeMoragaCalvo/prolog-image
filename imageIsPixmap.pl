:- module(imageIsPixmap, [imageIsPixmap/1]).

/*
DOMINIOS
X, Y, R, G, B, Depth, = Enteros+
Pixel, Pixels, Image = Listas

HECHOS
number/1.

REGLAS
positiveNumber/1, areAllPositive/1, pixelIsRGB/1, pixelsAreRGB/1, imageIsPixmap/1.

META PRINCIPAL
imageIsPixmap/1.

METAS SECUNDARIAS
positiveNumber/1, areAllPositive/1, pixelIsRGB/1, pixelsAreRGB/1.
*/



/*================================================== CODIGO ==========================================================================*/
positiveNumber(Pixel):- pixrgb(X, Y, _, _, _, Depth, Pixel),
    (number(X), X >= 0),
    (number(Y), Y >= 0),
    (number(Depth), Depth >= 0), !.


areAllPositive([]):- !.
areAllPositive([Pixel|Pixels]):- positiveNumber(Pixel), areAllPositive(Pixels), !.


pixelIsRGB(Pixel):- pixrgb(_, _, R, G, B, _, Pixel),
    (R >= 0, R =< 255),
    (G >= 0, B =< 255),
    (B >= 0, B =< 255), !.


pixelsAreRGB([]):- !.
pixelsAreRGB([Pixel|Pixels]):- pixelIsRGB(Pixel), pixelsAreRGB(Pixels), !.

imageIsPixmap(Image):- image(_, _, Pixel, Image), pixelsAreRGB(Pixel), areAllPositive(Pixel), !.
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
%pixrgb(1, 1, 240, 240, 240, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%True

%pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
%pixrgb(1, 1, 256, 256, 256, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%false. En el Pixel 4, los canales RGB exceden en 1 el valor maximo.

%pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
%pixrgb(1, -1, 240, 240, 240, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%false. El "alto" del Pixel 4 es negativo.
/*========================================================================================================================================*/