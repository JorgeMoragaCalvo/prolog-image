:- module(image, [image/4]).

/*
DOMINIOS
N, Width, Height = Enteros+
T, Pixels = Listas


PREDICADOS
myListLength(L, N).
image(Width, Height, Pixels, [Width, Height, Pixels]).


META PRIMARIA
image


META SECUNDARIA
myListLength
*/

/*======================= CODIGO ==========================*/
myListLength([], 0):- !.
myListLength([_|T], N):- myListLength(T, N1), N is N1 + 1.

image(Width, Height, Pixels, [Width, Height, Pixels]):-
    myListLength(Pixels, N), N is (Width * Height).
/*=========================================================*/