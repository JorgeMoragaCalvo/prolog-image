:- module(imageIsBitmap, [imageIsBitmap/1]).

isZeroOne(N):- N is 0, !; N is 1.

getFirstElement([X|_], X).
getSecondElement([_, X|_], X).
getThirdElement([_,_,X|_], X).
myLast(Element, [Element]):- !.
myLast(Element, [_|T]):- myLast(Element, T).


% Si el tercer elemento de la lista es 0 o 1.
thirdZeroOne(L):- getThirdElement(L, X), isZeroOne(X).

% Verifica si en cada elemento de una lista (de listas) el tercer elemento es 0 o 1.
listZeroOne(L):- maplist(thirdZeroOne, L).


isPositive(N):- N >= 0, number(N).

%listPositive(L):- getFirstElement(L, X), isPositive(X), getSecondElement(L, Y), isPositive(Y), getThirdElement(L, B), isPositive(B), myLast(D, L), isPositive(D).

listPositive([]):- !.
listPositive([H|T]):- isPositive(H), listPositive(T).

%Verifica si todos los elementos de las sublistas son positivos >= 0.
allPositive(L):- maplist(listPositive, L).


%bitmap(L):- maplist(thirdZeroOne, L), maplist(listPositive, L).

%largo lista igual 4.
lengthFour(L):- length(L, X), X is 4.

%largo de cada sublista = 4.
listLengthFour(L):- maplist(lengthFour, L).

%prototipo funcion bitmap?
bitmap(L):- maplist(thirdZeroOne, L), maplist(listPositive, L), maplist(lengthFour, L).


%------------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------------------

isnumberPositive(Pixel):- pixbit(X, Y, _, Depth, Pixel),
    (number(X), X >= 0),
    (number(Y), Y >= 0),
    (number(Depth), Depth >= 0), !.

elementsArePositive([]):- !.
elementsArePositive([Pixel|Pixels]):- isnumberPositive(Pixel), elementsArePositive(Pixels), !.

pixelIsBitmap(Pixel):- pixbit(_, _, Bit, _, Pixel), (Bit == 0; Bit == 1), !.

pixelsAreBitmap([]):- !.
pixelsAreBitmap([Pixel| Pixels]):- pixelIsBitmap(Pixel), pixelsAreBitmap(Pixels).

imageIsBitmap(Image):- image(_, _, Pixels, Image), pixelsAreBitmap(Pixels), 
    elementsArePositive(Pixels), !.

%------------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------------------


%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsBitmap(I).
%True.

%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 2, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsBitmap(I).
%false. El Bit del Pixel 3, no es ni 0 ni 1.

%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(-1, 1, 0, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsBitmap(I).
%false. La coordenada X del Pixel 4 es negativa.