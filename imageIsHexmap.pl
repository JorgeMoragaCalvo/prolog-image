:- module(imageIsHexmap, [imageIsHexmap/1]).

isString(N):- string(N).

getFirst([X|_], X).
getSecond([_,X|_], X).
myLast(Element, [Element]):- !.
myLast(Element, [_|T]):- myLast(Element, T).

myLength([], 0):- !.
myLength([_|T], N):- myLength(T, N1), N is N1 + 1.

greaterThanZero(X):- X >= 0.

numbersPositive(L):- getFirst(L, X), greaterThanZero(X), getSecond(L, Y), greaterThanZero(Y), myLast(D, L), greaterThanZero(D).

getThirdElement([_,_,X|_], X).

thirdElementString(L):- getThirdElement(L, X), isString(X).

isLengthFour(L):- myLength(L, X), X is 4.

%Comprueba si cada sublista es de largo 4.
listsLengthFour(L):- maplist(isLengthFour, L).

%hexmap?
hexmap(L):- maplist(thirdElementString, L), maplist(isLengthFour, L), maplist(numbersPositive, L).

/*
myMaplist(Goal, [Elem1|Tail1], [Elem2|Tail2]) :-
        apply(Goal, [Elem1, Elem2]), 
        myMaplist(Goal, Tail1, Tail2).
*/

%-----------------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------------

isGreaterThanZero(Pixel):- pixhex(X, Y, _, Depth, Pixel),
        (number(X), X >= 0),
        (number(Y), Y >= 0),
        (number(Depth), Depth >= 0), !.


areGreaterThanZero([]):- !.
areGreaterThanZero([Pixel|Pixels]):- isGreaterThanZero(Pixel), areGreaterThanZero(Pixels), !.


pixelIsHex(Pixel):- pixhex(_, _, Hex, _, Pixel), isString(Hex), !.


pixelsAreHex([]):- !.
pixelsAreHex([Pixel|Pixels]):- pixelIsHex(Pixel), pixelsAreHex(Pixels), !.

imageIsHexmap(Image):- image(_, _, Pixel, Image), pixelsAreHex(Pixel), areGreaterThanZero(Pixel), !.

%pixhex(0, 0, "rojo", 10, P1), pixhex(0, 1, "azul", 20, P2), pixhex(1, 0, "verde", 30, P3), pixhex(1, 1, "amarillo", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%True.

%pixhex(0, 0, "rojo", 10, P1), pixhex(0, 1, "azul", 20, P2), pixhex(1, 0, verde, 30, P3), 
%pixhex(1, 1, "amarillo", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%false. El color del Pixel 3 no es un string.

%pixhex(0, 0, "rojo", 10, P1), pixhex(0, 1, "azul", 20, P2), pixhex(-1, 0, "verde", 30, P3), 
%pixhex(1, 1, "amarillo", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%false. La coordenada X del Pixel 3 es negativa.

