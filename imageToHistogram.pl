:- module(imageToHistogram, [imageToHistogram/2]).

frequency([], []).
frequency([X|Xs], F):- tabulate(Xs, X:1, F).
                           

tabulate([], C:N, [C:N]).    
tabulate([X|Xs], X:N, F):- !, N1 is N+1, tabulate(Xs, X:N1, F).
tabulate([X|Xs], C:N, [C:N|F]):- tabulate(Xs, X:1, F).


%frequency([0,0,1,2,2], L).
%L = [0:2, 1:1, 2:2].

