:- module(imageFlipH, [imageFlipH/2]).

/*
DOMINIOS
Height, X, Y, Bit, Depth, Width, NewX, NewY = Enteros+
PixelIn, PixelOut, PixelsIn, PixelsOut, ImageIn, ImageOut = Listas

PREDICADOS
pixelFlipH(), pixelsFlipH(), imageFlipH().

META PRINCIPAL
imageFlipH()

METAS SECUNDARIAS
pixelFlipH(), pixelsFlipH().
*/


/*ESTRATEGIA DE RESOLUCION*/
%Girar la imagen horizontalmente
%Input
%2 * 2
%PA(0, 0)  PB(0, 1)
%PC(1, 0)  PD(1, 1)

%Output
%2 * 2
%PB(0, 0)  PA(0, 1)
%PD(1, 0)  PC(1, 1)

%PA(0, 0) -> (0, 1) -> Y + 1
%PB(0, 1) -> (0, 0) -> Y - 1
%PC(1, 0) -> (1, 1) -> Y + 1
%PD(1, 1) -> (1, 0) -> Y - 1
/*===============================*/

/*================================================== CODIGO ==========================================================================*/
pixelFlipH(Height, PixelIn, PixelOut):- (pixbit(X, Y, Bit, Depth, PixelIn) -> ((Y < Height - 1 -> NewY is Y + 1; NewY is Y - 1),
    pixbit(X, NewY, Bit, Depth, PixelOut)); pixrgb(X, Y, R, G, B, Depth, PixelIn) -> (Y < Height - 1 -> NewY is Y + 1; NewY is Y - 1),
    pixrgb(X, NewY, R, G, B, Depth, PixelOut)).


pixelsFlipH(_, [], []):- !.
pixelsFlipH(Height, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- pixelFlipH(Height, PixelIn, PixelOut),
    pixelsFlipH(Height, PixelsIn, PixelsOut), !.

imageFlipH(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), pixelsFlipH(Height, PixelsIn, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).
/*====================================================================================================================================*/

/*=============================================  SCRIPTS DE PRUEBAS  =====================================================================*/
%pixbit(0,0,1,10, P1), pixbit(0,1,0,20, P2), pixbit(1,0,1,30,P3), pixbit(1,1,1,40,P4), image(2,2, [P1,P2,P3,P4],I), imageFlipH(I, I1).
%P1 = [0, 0, 1, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 1, 10], [0, 1, 0, 20], [1, 0, 1, 30], [1, 1, 1, 40]]],
%I1 = [2, 2, [[0, 1, 1, 10], [0, 0, 0, 20], [1, 1, 1, 30], [1, 0, 1, 40]]].


%pixhex(0, 0, "#FFFFFF", 10, P1), pixhex(0, 1, "#FFFFFF", 20, P2), pixhex(1, 0, "#FFFFFF", 30, P3), pixhex(1, 1, "#FFFFFF", 40, P4), 
%image(2, 2, [P1, P2, P3, P4], I), imageFlipH(I, I1); true.
%P1 = [0, 0, "#FFFFFF", 10],
%P2 = [0, 1, "#FFFFFF", 20],
%P3 = [1, 0, "#FFFFFF", 30],
%P4 = [1, 1, "#FFFFFF", 40],
%I = [2, 2, [[0, 0, "#FFFFFF", 10], [0, 1, "#FFFFFF", 20], [1, 0, "#FFFFFF", 30], [1, 1, "#FFFFFF", 40]]],
%I1 = [2, 2, [[0, 1, "#FFFFFF", 10], [0, 0, "#FFFFFF", 20], [1, 1, "#FFFFFF", 30], [1, 0, "#FFFFFF", 40]]].


%pixrgb(0, 0, 210, 210, 210, 10, P1), pixrgb(0, 1, 220, 220, 220, 20, P2), pixrgb(1, 0, 230, 230, 230, 30, P3), pixrgb(1, 1, 240, 240, 240, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageFlipH(I, I1).
%P1 = [0, 0, 210, 210, 210, 10],
%P2 = [0, 1, 220, 220, 220, 20],
%P3 = [1, 0, 230, 230, 230, 30],
%P4 = [1, 1, 240, 240, 240, 40],
%I = [2, 2, [[0, 0, 210, 210, 210, 10], [0, 1, 220, 220, 220, 20], [1, 0, 230, 230, 230, 30], [1, 1, 240, 240, 240, 40]]],
%I1 = [2, 2, [[0, 1, 210, 210, 210, 10], [0, 0, 220, 220, 220, 20], [1, 1, 230, 230, 230, 30], [1, 0, 240, 240, 240, 40]]].
/*========================================================================================================================================*/