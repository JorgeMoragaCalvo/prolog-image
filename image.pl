:- module(image, [image/4]).

myListLength([], 0):- !.
myListLength([_|T], N):- myListLength(T, N1), N is N1 + 1.

image(Width, Height, Pixels, [Width, Height, Pixels]):-
    myListLength(Pixels, N), N is (Width * Height).