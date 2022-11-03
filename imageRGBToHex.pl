:- module(imageRGBToHex, [imageRGBToHex/2]).


/*PROCEDIMIENTO PARA CONVERTIR NUMERO N A HEXADECIMAL Y CONVERTIR NUMERO A STRING*/
toHex1(X, N):- N is X rem 16.

toHex2(X, N):- A is X div 16, N is A rem 16.

toHexProof1(X, N):- toHex2(X, N). %number_string(N1, N).
toHexProof2(X, N):- toHex1(X, N). %number_string(N1, N).

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

/*====================================================================================*/
