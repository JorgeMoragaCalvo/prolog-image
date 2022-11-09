:- module(imageInvertColorRGB, [imageInvertColorRGB/2]).
:- use_module(imageChangePixel).

invertNumber(X, N):- N is (255 - X).


pixelRGB(PixelIn, PixelOut):- pixrgb(X, Y, R, G, B, Depth, PixelIn), 
    invertNumber(R, NewR),
    invertNumber(G, NewG),
    invertNumber(B, NewB),
    pixrgb(X, Y, NewR, NewG, NewB, Depth, PixelOut).


invertPixelsRGB([], []):- !.
invertPixelsRGB([PixelIn|PixelsIn], [PixelOut|PixelsOut]):- pixelRGB(PixelIn, PixelOut),
    invertPixelsRGB(PixelsIn, PixelsOut), !.


imageInvertColorRGB(Pixel, PModificado):- pixelRGB(Pixel, PModificado). 


%imageInvertColorRGB(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), invertPixelsRGB(PixelsIn, PixelsOut),
%    image(Width, Height, PixelsOut, ImageOut).


/*=============================================  SCRIPTS DE PRUEBA  =====================================================================*/
%Se modifica el segundo pixel.
%pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
%image(2, 2, [P1,P2,P3,P4], I), imageInvertColorRGB(P2, P2_Modificado), imageChangePixel(I, P2_Modificado, I2); true.
%P1 = [0, 0, 10, 10, 10, 10],
%P2 = [0, 1, 20, 20, 20, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 10, 10, 10, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]],
%P2_Modificado = [0, 1, 235, 235, 235, 20],
%I2 = [2, 2, [[0, 0, 10, 10, 10, 10], [0, 1, 235, 235, 235, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]].


%Se modifica el primer pixel.
%pixrgb(0, 0, 0, 0, 0, 0, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
%image(2, 2, [P1,P2,P3,P4], I), imageInvertColorRGB(P1, P1_Modificado), imageChangePixel(I, P1_Modificado, I2); true.
%P1 = [0, 0, 0, 0, 0, 10],
%P2 = [0, 1, 20, 20, 20, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]],
%P1_Modificado = [0, 0, 255, 255, 255, 10],
%I2 = [2, 2, [[0, 0, 255, 255, 255, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]].


%Se modifica el ultimo pixel.
%pixrgb(0, 0, 0, 0, 0, 0, P1), pixrgb(0, 1, 20, 20, 20, 20, P2), pixrgb(1, 0, 30, 30, 30, 30, P3), pixrgb(1, 1, 40, 40, 40, 40, P4), 
%image(2, 2, [P1, P2, P3, P4], I), imageInvertColorRGB(P4, P4_Modificado), imageChangePixel(I, P4_Modificado, I2); true.
%P1 = [0, 0, 0, 0, 0, 10],
%P2 = [0, 1, 20, 20, 20, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]],
%P4_Modificado = [1, 1, 215, 215, 215, 40],
%I2 = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 215, 215, 215, 40]]].
/*=======================================================================================================================================*/