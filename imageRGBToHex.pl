:- module(imageRGBToHex, [imageRGBToHex/2]).


/*PROCEDIMIENTO PARA CONVERTIR NUMERO N A HEXADECIMAL Y CONVERTIR NUMERO A STRING*/
toHex1(X, N):- N is X rem 16.

toHex2(X, N):- A is X div 16, N is A rem 16.

toHexProof1(X, N):- toHex2(X, N). %number_string(N1, N).
toHexProof2(X, N):- toHex1(X, N). %number_string(N1, N).

toHex(X, N):- toHexProof1(X, N1), hexNumber(N1, N3), toHexProof2(X, N2), hexNumber(N2, N4), string_concat(N3, N4, N).


hexNumber(X, N):- ((X >= 0, X =< 9) -> number_string(X, N); hexNumbers(X, N)).

