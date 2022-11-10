:- module(imageFlipV, [imageFlipV/2]).

/*
DOMINIOS
Height, X, Y, Bit, Depth, Width, NewX, NewY = Enteros+
PixelIn, PixelOut, PixelsIn, PixelsOut, ImageIn, ImageOut = Listas

PREDICADOS
pixelFlipV/3, pixelsFlipV/3, imageFlipV/2.

META PRINCIPAL
imageFlipV/2

METAS SECUNDARIAS
pixelFlipV/3, pixelsFlipV/3.
*/


/*ESTRATEGIA DE RESOLUCION*/
%Girar la imagen verticalmente
%Input
%2 * 2
%PA(0, 0)  PB(0, 1)
%PC(1, 0)  PD(1, 1)

%Output
%2 * 2 <- solo se modifica la coordenada X de cada par.
%PC(0, 0)  PD(0, 1)
%PA(1, 0)  PB(1, 1)

%PA(0, 0) -> (1, 0) -> X - 1
%PB(0, 1) -> (1, 1) -> X - 1
%PC(1, 0) -> (0, 0) -> X + 1
%PD(1, 1) -> (0, 1) -> X - 1


/*================================================== CODIGO ==========================================================================*/
pixelFlipV(Width, PixelIn, PixelOut):- (pixbit(X, Y, Bit, Depth, PixelIn) -> ((X < Width - 1 -> NewX is X + 1; NewX is X - 1), 
    pixbit(NewX, Y, Bit, Depth, PixelOut)); pixrgb(X, Y, R, G, B, Depth, PixelIn) -> (X < Width - 1 -> NewX is X + 1; NewX is X - 1),
    pixrgb(NewX, Y, R, G, B, Depth, PixelOut)).

pixelsFlipV(_, [], []):- !.
pixelsFlipV(Width, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- pixelFlipV(Width, PixelIn, PixelOut),
    pixelsFlipV(Width, PixelsIn, PixelsOut), !.

imageFlipV(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), pixelsFlipV(Width, PixelsIn, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).
/*====================================================================================================================================*/

/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0,0,1,10, P1), pixbit(0,1,0,20, P2), pixbit(1,0,1,30,P3), pixbit(1,1,1,40,P4), image(2,2, [P1,P2,P3,P4],I), imageFlipV(I, I1); true.
%P1 = [0, 0, 1, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 1, 10], [0, 1, 0, 20], [1, 0, 1, 30], [1, 1, 1, 40]]],
%I1 = [2, 2, [[1, 0, 1, 10], [1, 1, 0, 20], [0, 0, 1, 30], [0, 1, 1, 40]]].


%pixhex(0, 0, "#FFFFFF", 10, P1), pixhex(0, 1, "#FFFFFF", 20, P2), pixhex(1, 0, "#FFFFFF", 30, P3), pixhex(1, 1, "#FFFFFF", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageFlipV(I, I1); true.
%P1 = [0, 0, "#FFFFFF", 10],
%P2 = [0, 1, "#FFFFFF", 20],
%P3 = [1, 0, "#FFFFFF", 30],
%P4 = [1, 1, "#FFFFFF", 40],
%I = [2, 2, [[0, 0, "#FFFFFF", 10], [0, 1, "#FFFFFF", 20], [1, 0, "#FFFFFF", 30], [1, 1, "#FFFFFF", 40]]],
%I1 = [2, 2, [[1, 0, "#FFFFFF", 10], [1, 1, "#FFFFFF", 20], [0, 0, "#FFFFFF", 30], [0, 1, "#FFFFFF", 40]]].


%pixrgb(0,0,0,0,0,10,P1), pixrgb(0,1,10,10,10,20,P2),  pixrgb(1,0,20,20,20,30,P3), pixrgb(1,1,30,30,30,40,P4),image(2,2,[P1,P2,P3,P4], I), 
%imageFlipV(I, I1); true.
%P1 = [0, 0, 0, 0, 0, 10],
%P2 = [0, 1, 10, 10, 10, 20],
%P3 = [1, 0, 20, 20, 20, 30],
%P4 = [1, 1, 30, 30, 30, 40],
%I = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 10, 10, 10, 20], [1, 0, 20, 20, 20, 30], [1, 1, 30, 30, 30, 40]]],
%I1 = [2, 2, [[1, 0, 0, 0, 0, 10], [1, 1, 10, 10, 10, 20], [0, 0, 20, 20, 20, 30], [0, 1, 30, 30, 30, 40]]].
/*========================================================================================================================================*/