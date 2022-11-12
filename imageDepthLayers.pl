:- module(imageDepthLayers, [imageDepthLayers/2]).

/*
exclude(_, [], []).
exclude(P, [X|Xs], S):- call(P, X), !, exclude(P, Xs, S).
exclude(P, [X|Xs], [X|S]):- exclude(P, Xs, S).
*/

/*
DOMINIOS
ImageIn, ImageLayers = Listas

REGLAS
imageDepthLayers/2.

META PRINCIPAL
imageDepthLayers/2

METAS SECUNDARIAS
identical/2, filterList/3, filterListIncl/3, positionOfPixel/3, newPixelBit/4, posXposYGenerator/3, posXGenerator/3,
posYGenerator/3, depthBit/3, depthRgb/3, pixelsGeneratorLayersBit/3.
*/

/*================================================== CODIGO ==========================================================================*/
identical(X, Y):- X == Y.

filterList(A, In, Out) :- exclude(identical(A), In, Out).

filterListIncl(A, In, Out) :- include(identical(A), In, Out).


positionOfPixel(X, Y, [X, Y]).

newPixelBit(Pos, Color, Depth, Pixel):- positionOfPixel(X, Y, Pos), pixbit(X, Y, Color, Depth, Pixel).


posXposYGenerator(Width, Height, POut):- NewWidth is Width - 1, NewHeight is Height - 1, 
    posXGenerator(NewWidth, NewHeight, POut).


posXGenerator(0, J, R):- posYGenerator(0, J, R), !.
posXGenerator(I, J, R):- Kant is I - 1, posYGenerator(I, J, Raux),
    append(Raux, Rant, R), posXGenerator(Kant, J, Rant).


posYGenerator(I, 0, R):- R = [[I, 0]], !.
posYGenerator(I, J, R):- Kant is J - 1, append([[I, J]], Rant, R),
    posYGenerator(I, Kant, Rant).


depthBit(D, Pixel, POut):- pixbit(X, Y, Bit, Depth, Pixel),
    (Depth = D -> pixbit(X, Y, Bit, Depth, POut); POut = "false").


allDepthBit(_, [], []):- !.
allDepthBit(Depth, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- depthBit(Depth, PixelIn, PixelOut),
    allDepthBit(Depth, PixelsIn, PixelsOut).


allDepthBits([], _, []):- !.
allDepthBits([Depth|DepthsList], PixelsIn, [PixelOut|PixelsList]):-
    allDepthBit(Depth, PixelsIn, PixelOut),
    allDepthBits(DepthsList, PixelsIn, PixelsList).



depthRgb(D, P, POut):- pixrgb(PosX, PosY, R, G, B, Depth, P),
    (Depth = D -> pixrgb(PosX, PosY, R, G, B, Depth, POut); POut = "false").


allDepthRGB(_, [], []):- !.
allDepthRGB(Depth, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- depthRgb(Depth, PixelIn, PixelOut),
    allDepthRGB(Depth, PixelsIn, PixelsOut).


allDepthRGBs([], _, []):- !.
allDepthRGBs([Depth|DepthsList], PixelsIn, [PixelOut|PixelsList]):- allDepthRGB(Depth, PixelsIn, PixelOut),
    allDepthRGBs(DepthsList, PixelsIn, PixelsList).



depthHex(D, P, POut):- pixhex(PosX, PosY, Hex, Depth, P),
    (Depth = D -> pixbit(PosX, PosY, Hex, Depth, POut); POut = "false").


allDepthHex(_,[],[]):- !.
allDepthHex(Depth, [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- depthHex(Depth, PixelIn, PixelOut),
    allDepthHex(Depth, PixelsIn, PixelsOut).


allDepthHexs([],_,[]):- !.
allDepthHexs([Depth|DepthsList], PixelsIn, [PixelOut|PixelsList]):- allDepthHex(Depth, PixelsIn, PixelOut),
    allDepthHexs(DepthsList, PixelsIn, PixelsList).


clearList([],[]):- !.
clearList([PixelList|PixelLists],[PixelOut|PixelsListsOut]):- exclude(string, PixelList, PixelOut),
    clearList(PixelLists,PixelsListsOut).



getDepthBit(PixelIn, DepthOut):- pixbit(_, _, _, Depth, PixelIn), DepthOut = Depth.


getDepthBits([],[]):- !.
getDepthBits([Pixel|Pixels], [DepthOut|DepthsOut]):- getDepthBit(Pixel, DepthOut), getDepthBits(Pixels, DepthsOut).


getDepthRGB(PixelIn, DepthOut):- pixrgb(_, _, _, _, _, Depth, PixelIn), DepthOut = Depth.

getDepthRGBs([], []):- !.
getDepthRGBs([Pixel|Pixels], [DepthOut|DepthsOut]):- getDepthRGB(Pixel, DepthOut), getDepthRGBs(Pixels, DepthsOut).


getDepthHex(PixelIn, DepthOut):- pixhex(_, _, _, Depth, PixelIn), DepthOut = Depth.

getDepthHexs([], []):- !.
getDepthHexs([Pixel|Pixels], [DepthOut|DepthsOut]):- getDepthHex(Pixel, DepthOut), getDepthHexs(Pixels, DepthsOut).



filterDepths([], []):- !.
filterDepths([Depth|DepthsListIn], DepthsList):- filterList(Depth, DepthsListIn, DepthsListInAux),
    append([Depth], Rant, DepthsList), filterDepths(DepthsListInAux, Rant).


getPositionsBit([], []):-  !.
getPositionsBit([Pixel|PixelsList], [PosL|PositionsAuxListO]):-
    getPositionsOfImageCompressedBit(Pixel, PosL),
    getPositionsBit(PixelsList, PositionsAuxListO).

getPositionsRgb([], []).
getPositionsRgb([Pixel|PixelsList], [PosL|PositionsAuxListO]):- getPositionsOfImageCompressedRgb(Pixel, PosL),
    getPositionsRgb(PixelsList, PositionsAuxListO).

getPositionsHex([],[]):- !.
getPositionsHex([Pixel|PixelsList], [PosL|PositionsAuxListO]):- getPositionsOfImageCompressedHex(Pixel, PosL),
    getPositionsHex(PixelsList, PositionsAuxListO).


filterPositions([], R, R):- !.
filterPositions([Pos|Positions], PositionsImage , PositionsImageDescompressedOut):-
    filterList(Pos, PositionsImage, PositionsImageDescompressedOutAux),
    filterPositions(Positions, PositionsImageDescompressedOutAux, PositionsImageDescompressedOut).

positionsMissing([], _, []):- !.
positionsMissing([Pgen|Pgens], PgensList, [PosList|PosListsOut]):- filterPositions(Pgen, PgensList, PosList),
    positionsMissing(Pgens, PgensList, PosListsOut).



pixelsGeneratorLayersBit([], _, _, []):- !.
pixelsGeneratorLayersBit([Pos|PositionsImageDescompressedOut], Color, Depth, [Pixel|PixelsAuxOut]):- newPixelBit(Pos,Color,Depth,Pixel),
    pixelsGeneratorLayersBit(PositionsImageDescompressedOut, Color, Depth, PixelsAuxOut).

pixelsGeneratorListsBit([], [], []):- !.
pixelsGeneratorListsBit([Pixel|Pixels], [Depth|DepthsList], [PixelOut|PixelsListsOut]):- pixelsGeneratorLayersBit(Pixel, 0, Depth, PixelOut),
    pixelsGeneratorListsBit(Pixels,DepthsList, PixelsListsOut).


colorRGB(R, G, B,[R, G, B]).

newPixelRgbP(Pos, Color, Depth, Pixel):- positionOfPixel(X, Y, Pos), colorRGB(R, G, B, Color), pixrgb(X, Y, R, G, B, Depth, Pixel).

pixelsGeneratorLayersRgb([], _, _, []):- !.
pixelsGeneratorLayersRgb([Pos|PositionsImageDescompressedOut], Color, Depth, [P|PixelsAuxOut]):- newPixelRgbP(Pos,Color,Depth,P),
    pixelsGeneratorLayersRgb(PositionsImageDescompressedOut, Color, Depth, PixelsAuxOut).

pixelsGeneratorListsRgb([], [], []):- !.
pixelsGeneratorListsRgb([Pixel|Pixels], [Depth|DepthsList], [PixelOut|PixelsListsOut]):- 
    pixelsGeneratorLayersRgb(Pixel, [255, 255, 255], Depth, PixelOut),
    pixelsGeneratorListsRgb(Pixels, DepthsList, PixelsListsOut).


newPixelHex(Pos,Color,D,P):- positionOfPixel(X,Y,Pos), pixhex(X,Y,Color,D,P).


pixelsGeneratorLayersHex([], _, _, []):- !.
pixelsGeneratorLayersHex([Pos|PositionsImageDescompressedOut], Color, Depth, [Pixel|PixelsAuxOut]):- newPixelHex(Pos, Color, Depth, Pixel),
    pixelsGeneratorLayersHex(PositionsImageDescompressedOut, Color, Depth, PixelsAuxOut).

pixelsGeneratorListsHex([], [], []):- !.
pixelsGeneratorListsHex([Pixel|Pixels], [Depth|DepthsList], [POut|PixelsListsOut]):- pixelsGeneratorLayersHex(Pixel, "FFFFFF", Depth, POut),
    pixelsGeneratorListsHex(Pixels, DepthsList, PixelsListsOut).


mergePixels(Pixels, PixelsAuxOut, PixelsOut):- append(Pixels, PixelsAuxOut, PixelsOut).

mergePixelsLists([], [], []):- !.
mergePixelsLists([Pixel|Pixels], [PixelIn|PixelsIn], [PixelOut|PixelsOut]):- mergePixels(Pixel, PixelIn, PixelOut),
    mergePixelsLists(Pixels, PixelsIn, PixelsOut).

imagesGenerator(_, _, [], []):- !.
imagesGenerator(Width, Height ,[Pixel|Pixels], [ImageOut|ImagesByLayers]):- image(Width, Height, Pixel, ImageOut),
    imagesGenerator(Width, Height, Pixels, ImagesByLayers).


getPositionBit(PixelIn, POut):- pixbit(X, Y, _, _, PixelIn), POut = [X, Y].
    
getPositionsOfImageCompressedBit([], []):- !.
getPositionsOfImageCompressedBit([PixelIn|PixelsIn], [PosOut|PositionsOut]):- getPositionBit(PixelIn, PosOut),
     getPositionsOfImageCompressedBit(PixelsIn, PositionsOut).

getPositionRgb(PixelIn, POut):- pixrgb(X, Y, _, _, _, _, PixelIn), POut = [X, Y].
    
getPositionsOfImageCompressedRgb([],[]):- !.
getPositionsOfImageCompressedRgb([PixelIn|PixelsIn], [ PosOut|PositionsOut]):- getPositionRgb(PixelIn, PosOut),
     getPositionsOfImageCompressedRgb(PixelsIn, PositionsOut).

getPositionHex(PixelIn, POut):- pixhex(X, Y, _, _, PixelIn), POut = [X, Y].
    
getPositionsOfImageCompressedHex([], []):- !.
getPositionsOfImageCompressedHex([PixelIn|PixelsIn], [PosOut|PositionsOut]):- getPositionHex(PixelIn, PosOut),
     getPositionsOfImageCompressedHex(PixelsIn, PositionsOut).


imageDepthLayers(ImageIn, ImageLayers):- image(Width, Height, PixelsIn, ImageIn), posXposYGenerator(Width, Height, PositionsOut),
    (imageIsBitmap(ImageIn) -> getDepthBits(PixelsIn, DepthsListAux); (imageIsPixmap(ImageIn) -> getDepthRGBs(PixelsIn, DepthsListAux);
    getDepthHexs(PixelsIn, DepthsListAux))),
    filterDepths(DepthsListAux, DepthsList), 
    (imageIsBitmap(ImageIn) -> allDepthBits(DepthsList, PixelsIn, PixelsLists);
    (imageIsPixmap(ImageIn) -> allDepthRGBs(DepthsList, PixelsIn, PixelsLists);
    allDepthHexs(DepthsList, PixelsIn, PixelsLists))),
    clearList(PixelsLists,PixelsListsOutAux),
    (imageIsBitmap(ImageIn) -> getPositionsBit(PixelsListsOutAux, PositionsAuxOut); 
    (imageIsPixmap(ImageIn) -> getPositionsRgb(PixelsListsOutAux, PositionsAuxOut);
    getPositionsHex(PixelsListsOutAux, PositionsAuxOut))),
    positionsMissing(PositionsAuxOut,PositionsOut, PositionsListsOut),
    (imageIsBitmap(ImageIn) -> pixelsGeneratorListsBit(PositionsListsOut, DepthsList, PixelsListsMissingOut);
    (imageIsPixmap(ImageIn) -> pixelsGeneratorListsRgb(PositionsListsOut, DepthsList, PixelsListsMissingOut);
    pixelsGeneratorListsHex(PositionsListsOut, DepthsList, PixelsListsMissingOut))),
    mergePixelsLists(PixelsListsMissingOut, PixelsListsOutAux, PixelsMergedLists),
    imagesGenerator(Width, Height ,PixelsMergedLists, ImageLayers).
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 1, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 0, 30, P3), pixbit(1, 1, 1, 10, P4), image(2, 2,[P1, P2, P3, P4],I),
%imageDepthLayers(I, I1); true.
%P1 = [0, 0, 1, 10],
%P2 = [0, 1, 0, 20],
%P3 = [0, 2, 0, 30],
%P4 = [1, 0, 1, 10],
%I = [2, 2, [[0, 0, 1, 10], [0, 1, 0, 20], [0, 2, 0, 30], [1, 0, 1, 10]]],
%I1 = [[2, 2, [[1, 1, 0, 10], [0, 1, 0, 10], [0, 0, 1, 10], [1, 0, 1, 10]]], [2, 2, [[1, 1, 0, 20], [1, 0, 0, 20], [0, 0, 0, 20], 
%[0, 1, 0, 20]]], [2, 2, [[1, 1, 0, 30], [1, 0, 0, 30], [0, 1, 0, 30], [0, 0, 0, 30], [0, 2, 0, 30]]]].


%pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2), pixrgb(1, 0, 30, 30, 30, 30, P3), pixrgb(1, 1, 40, 40, 40, 40, P4),
%image(2, 2, [P1, P2, P3, P4],I), imageDepthLayers(I, I1); true.
%P1 = [0, 0, 10, 10, 10, 10],
%P2 = [0, 1, 20, 20, 20, 20],
%P3 = [1, 0, 30, 30, 30, 30],
%P4 = [1, 1, 40, 40, 40, 40],
%I = [2, 2, [[0, 0, 10, 10, 10, 10], [0, 1, 20, 20, 20, 20], [1, 0, 30, 30, 30, 30], [1, 1, 40, 40, 40, 40]]],
%I1 = [[2, 2, [[1, 1, 255, 255, 255, 10], [1, 0, 255, 255, 255, 10], [0, 1, 255, 255, 255, 10], [0, 0, 10, 10, 10, 10]]], 
%[2, 2, [[1, 1, 255, 255, 255, 20], [1, 0, 255, 255, 255, 20], [0, 0, 255, 255, 255, 20], [0, 1, 20, 20, 20, 20]]], 
%[2, 2, [[1, 1, 255, 255, 255, 30], [0, 1, 255, 255, 255, 30], [0, 0, 255, 255, 255, 30], [1, 0, 30, 30, 30, 30]]], 
%[2, 2, [[1, 0, 255, 255, 255, 40], [0, 1, 255, 255, 255, 40], [0, 0, 255, 255, 255, 40], [1, 1, 40, 40, 40, 40]]]].
/*=======================================================================================================================================*/
