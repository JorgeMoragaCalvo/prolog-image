:- module(imageToHistogram, [imageToHistogram/2]).

frequency([], []).
frequency([X|Xs], F):- tabulate(Xs, X:1, F).
                           

tabulate([], C:N, [C:N]).    
tabulate([X|Xs], X:N, F):- !, N1 is N+1, tabulate(Xs, X:N1, F).
tabulate([X|Xs], C:N, [C:N|F]):- tabulate(Xs, X:1, F).


%frequency([0,0,1,2,2], L).
%L = [0:2, 1:1, 2:2].

%frequency([0,0,1,2,2], L).
%L = [0:2, 1:1, 2:2].

pixbit(X, Y, Bit, Depth, [X, Y, Bit, Depth]).
image(Width, Height, Pixels, [Width, Height, Pixels]).
pixrgb(X, Y, R,G,B, Depth, [X, Y, R,G,B, Depth]).

car([H|_], H).
cdr([_|T], T).

second(L, N):- cdr(L, L1), car(L1, N).
third(L, N):- cdr(L, L1), cdr(L1, L2), car(L2, N).
fourth(L, N):- cdr(L, L1), cdr(L1, L2), cdr(L2, L3), car(L3, N).
fifth(L, N):- cdr(L, L1), cdr(L1, L2), cdr(L2, L3), cdr(L3, L4), car(L4, N).

%bit(PixelIn, PixelOut):- pixbit(_,_,_,_,PixelIn), third(PixelIn, PixelOut).


thirdElement([], []):- !.
thirdElement([[_,_,Third|_]|Xs], [Third|Ys]):- thirdElement(Xs, Ys).


elements([], []):- !.
elements([[_, _, Third, Fourth, Fifth|_]| Xs], [Third, Fourth, Fifth|Ys]):- elements(Xs, Ys).


bitsElement(ImageIn, L):- image(_, _, _, ImageIn), third(ImageIn, L1), thirdElement(L1, L2), frequency(L2, L), !.


bitsElements(ImageIn, L):- image(_, _, _, ImageIn), third(ImageIn, L1), elements(L1, L2), frequency(L2, L), !.


imageToHistogram(ImageIn, L):- ((third(ImageIn, P), car(P, P1), length(P1, N), N is 6) -> bitsElements(ImageIn, L); bitsElement(ImageIn, L)).
%(bitsElement(ImageIn, L); bitsElements(ImageIn, L)), !.