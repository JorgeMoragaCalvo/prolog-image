:- module(imageRGBToHex, [imageRGBToHex/2]).

/*
DOMINIOS
N = String
R, G, B, X, Depth = Enteros+
PixelIn, PixelOut, PixelsOut, ImageIn, ImageOut = Listas

HECHOS
hexNumbers/2.

REGLAS
toHex1/2, toHex2/2, toHexProof1/2, toHexProof2/2, toHex/2, hexNumber/2, number_string/2, toHexAux/4.
toHexPixel/2, toHexPixels/2, imageRGBToHex/2.

META PRINCIPAL
imageRGBToHex/2.

METAS SECUNDARIAS
toHex1/2, toHex2/2, toHexProof1/2, toHexProof2/2, toHex/2, hexNumber/2, number_string/2, toHexAux/4, toHexPixel/2, toHexPixels/2.
*/


/*================================================== CODIGO ==========================================================================*/
toHex1(X, N):- N is X rem 16.

toHex2(X, N):- A is X div 16, N is A rem 16.

toHexProof1(X, N):- toHex2(X, N).
toHexProof2(X, N):- toHex1(X, N).

toHex(X, N):- toHexProof1(X, N1), hexNumber(N1, N3), toHexProof2(X, N2), hexNumber(N2, N4), string_concat(N3, N4, N).


hexNumber(X, N):- ((X >= 0, X =< 9) -> number_string(X, N); hexNumbers(X, N)).


hexNumbers(10, "A").
hexNumbers(11, "B").
hexNumbers(12, "C").
hexNumbers(13, "D").
hexNumbers(14, "E").
hexNumbers(15, "F").


toHexAux(R, G, B, N):- toHexProof1(R, R1), hexNumber(R1, R2), toHexProof2(R, R3), hexNumber(R3, R4), string_concat(R2, R4, R5),
    toHexProof1(G, G1), hexNumber(G1, G2), toHexProof2(G, G3), hexNumber(G3, G4), string_concat(G2, G4, G5), string_concat(R5, G5, RG),
    toHexProof1(B, B1), hexNumber(B1, B2), toHexProof2(B, B3), hexNumber(B3, B4), string_concat(B2, B4, B5), string_concat(RG, B5, N).


toHexPixel(PixelIn, PixelOut):- pixrgb(X, Y, R, G, B, Depth, PixelIn), toHexAux(R, G, B, Hex), pixhex(X, Y, Hex, Depth, PixelOut).


toHexPixels([], []):- !.
toHexPixels([PixelIn|PixelsIn], [PixelOut|PixelsOut]):- toHexPixel(PixelIn, PixelOut),
    toHexPixels(PixelsIn, PixelsOut).


imageRGBToHex(ImageIn, ImageOut):- image(Width, Height, PixelsIn, ImageIn), toHexPixels(PixelsIn, PixelsOut),
    image(Width, Height, PixelsOut, ImageOut).
/*========================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixrgb(0, 0, 220, 220, 220, 10, P1), pixrgb(0, 1, 230, 230, 230, 20, P2), pixrgb(1, 0, 240, 240, 240, 30, P3), 
%pixrgb(1, 1, 250, 250, 250, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1); true.
%P1 = [0, 0, 220, 220, 220, 10],
%P2 = [0, 1, 230, 230, 230, 20],
%P3 = [1, 0, 240, 240, 240, 30],
%P4 = [1, 1, 250, 250, 250, 40],
%I = [2, 2, [[0, 0, 220, 220, 220, 10], [0, 1, 230, 230, 230, 20], [1, 0, 240, 240, 240, 30], [1, 1, 250, 250, 250, 40]]],
%I1 = [2, 2, [[0, 0, "DCDCDC", 10], [0, 1, "E6E6E6", 20], [1, 0, "F0F0F0", 30], [1, 1, "FAFAFA", 40]]].


%pixrgb(0, 0, 110, 110, 110, 10, P1), pixrgb(0, 1, 120, 120, 120, 20, P2), pixrgb(1, 0, 130, 130, 130, 30, P3), pixrgb(1, 1, 140, 140, 140, 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1); true.
%P1 = [0, 0, 110, 110, 110, 10],
%P2 = [0, 1, 120, 120, 120, 20],
%P3 = [1, 0, 130, 130, 130, 30],
%P4 = [1, 1, 140, 140, 140, 40],
%I = [2, 2, [[0, 0, 110, 110, 110, 10], [0, 1, 120, 120, 120, 20], [1, 0, 130, 130, 130, 30], [1, 1, 140, 140, 140, 40]]],
%I1 = [2, 2, [[0, 0, "6E6E6E", 10], [0, 1, "787878", 20], [1, 0, "828282", 30], [1, 1, "8C8C8C", 40]]].


%pixrgb(0, 0, 70, 70, 70, 10, P1), pixrgb(0, 1, 80, 80, 80, 20, P2), pixrgb(1, 0, 90, 90, 90, 30, P3), pixrgb(1, 1, 100, 100, 100, 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1); true.
%P1 = [0, 0, 70, 70, 70, 10],
%P2 = [0, 1, 80, 80, 80, 20],
%P3 = [1, 0, 90, 90, 90, 30],
%P4 = [1, 1, 100, 100, 100, 40],
%I = [2, 2, [[0, 0, 70, 70, 70, 10], [0, 1, 80, 80, 80, 20], [1, 0, 90, 90, 90, 30], [1, 1, 100, 100, 100, 40]]],
%I1 = [2, 2, [[0, 0, "464646", 10], [0, 1, "505050", 20], [1, 0, "5A5A5A", 30], [1, 1, "646464", 40]]] .
/*========================================================================================================================================*/