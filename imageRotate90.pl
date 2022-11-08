:- module(imageRotate90, [pixelRotate90X/3, pixelRotate90Y/3, imageRotate90/2]).
:- use_module(imageFlipV).

pixelRotate90(Width, Height, PixelIn, PixelOut):- pixbit(X, Y, Bit, Depth, PixelIn), 
    %((X == Y, X < Width - 1) -> NewX is X + 1; NewX is X - 1), pixbit(NewX, Y, Bit, Depth, PixelOut).
    %((X =\= Y, Y < Height - 1) -> NewY is Y + 1; NewY is Y - 1), pixbit(X, NewY, Bit,Depth, PixelOut).
    ((X == Y, X < Width - 1) -> (NewX is X + 1; NewX is X - 1); ((X =\= Y, Y < Height - 1) -> NewY is Y + 1; NewY is Y - 1)),
    pixbit(NewX, NewY, Bit,Depth, PixelOut).

pixelRotate90X(Width, PixelIn, PixelOut):- pixbit(X, Y, Bit, Depth, PixelIn), 
    ((((X == Y, X < Width - 1) -> NewX is X + 1; NewX is X - 1) -> pixbit(NewX, Y, Bit, Depth, PixelOut)); 
    pixbit(X, Y, Bit,Depth,PixelOut)).

pixelRotate90Y(Height, PixelIn, PixelOut):- pixbit(X, Y, Bit, Depth, PixelIn),
    ((X =\= Y, Y < Height - 1) -> NewY is Y + 1; NewY is Y - 1), pixbit(X, NewY, Bit,Depth, PixelOut).

%pixbit(0,0,1,10,P1), pixelRotate90(2, 2, P1, P2).
%P1 = [0, 0, 1, 10],
%P2 = [1, 0, 1, 10].

%pixbit(1,1,1,10,P1), pixelRotate90(2, 2, P1, P2).
%P1 = [1, 1, 1, 10],
%P2 = [0, 1, 1, 10].

%pixbit(0,1,1,20,PA), pixelRotate90(2,2,PA, PB).
%PA = [0, 1, 1, 20],
%PB = [0, 0, 1, 20].

%pixbit(1,0,1,20,PA), pixelRotate90(2,2,PA, PB).
%PA = [1, 0, 1, 20],
%PB = [1, 1, 1, 20].

pixelsRotate90(_, _, [], []):- !.
pixelsRotate90(Width, Height, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- pixelRotate90(Width, Height, PixelIn, PixelOut),
    pixelsRotate90(Width, Height, PixelsIn, PixelsOut).

%imageRotate90(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), pixelsRotate90(Width, Height, PixelsIn, PixelsOut),
%    image(Width, Height, PixelsOut, ImageOut).

/*--------------------------------------------------------------------------------------------------------------*/

changePosXPosY(PixelIn, PixelOut):- (pixbit(X, Y, Bit, Depth, PixelIn) -> pixbit(Y, X, Bit, Depth, PixelOut);
    (pixrgb(X, Y, R, G, B, Depth, PixelIn) -> pixrgb(Y, X, R, G, B, Depth, PixelOut); !)).

changeAllPosXPosY([], []):- !.
changeAllPosXPosY([PixelIn|PixelsIn], [PixelOut|PixelsOut]):- changePosXPosY(PixelIn, PixelOut),
    changeAllPosXPosY(PixelsIn, PixelsOut), !.

imageChange(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), changeAllPosXPosY(PixelsIn, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut), !.

imageRotate90(ImageIn, ImageOut):- imageChange(ImageIn, Image), imageFlipV(Image, ImageOut).

/*--------------------------------------------------------------------------------------------------------------*/


/*=============================================  SCRIPTS DE PRUEBA  =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I), 
%imageRotate90(I, I1).
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1, 30], [1, 1, 1, 40]]],
%I1 = [2, 2, [[1, 0, 0, 10], [0, 0, 0, 20], [1, 1, 1, 30], [0, 1, 1, 40]]].


%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "F0F0F0", 20, P2), pixbit(1, 0, "FFFFFF", 30, P3), pixbit(1, 1, "F0F0F0", 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageRotate90(I, I1); true.
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "F0F0F0", 20],
%P3 = [1, 0, "FFFFFF", 30],
%P4 = [1, 1, "F0F0F0", 40],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "F0F0F0", 20], [1, 0, "FFFFFF", 30], [1, 1, "F0F0F0", 40]]],
%I1 = [2, 2, [[1, 0, "FFFFFF", 10], [0, 0, "F0F0F0", 20], [1, 1, "FFFFFF", 30], [0, 1, "F0F0F0", 40]]].


%pixrgb(0, 0, 0, 0, 0, 10, P1), pixrgb(0, 1, 10, 10, 10, 20, P2),  pixrgb(1, 0, 20, 20, 20, 30, P3), pixrgb(1, 1, 30, 30, 30, 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageRotate90(I, I1).
%P1 = [0, 0, 0, 0, 0, 10],
%P2 = [0, 1, 10, 10, 10, 20],
%P3 = [1, 0, 20, 20, 20, 30],
%P4 = [1, 1, 30, 30, 30, 40],
%I = [2, 2, [[0, 0, 0, 0, 0, 10], [0, 1, 10, 10, 10, 20], [1, 0, 20, 20, 20, 30], [1, 1, 30, 30, 30, 40]]],
%I1 = [2, 2, [[1, 0, 0, 0, 0, 10], [0, 0, 10, 10, 10, 20], [1, 1, 20, 20, 20, 30], [0, 1, 30, 30, 30, 40]]].
/*=======================================================================================================================================*/