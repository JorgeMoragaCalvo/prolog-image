:- module(imageToHistogram, [imageToHistogram/2]).

frequency([], []).   % the frequency table for the empty list is the empty list
frequency([X|Xs], F):-  % for a non-empty list,
  tabulate(Xs, X:1, F).   %   we just invoke the tabulation predicate, seeding the accumulator with the initial count.
                           

tabulate([], C:N, [C:N]).    
tabulate([X|Xs], X:N, F):- !, N1 is N+1, tabulate(Xs, X:N1, F).
tabulate([X|Xs], C:N, [C:N|F]):- tabulate(Xs, X:1, F).


%frequency([0,0,1,2,2], L).
%L = [0:2, 1:1, 2:2].

