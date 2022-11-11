:- module(imageToString, [imageToString/2]).

/*======================================= CODIGOS DE PRUEBA =====================================================================*/
pixel(A, B, C, D, [A, B, C, D]).

pixeles(P, [P]).

print_matrix([]).
print_matrix([Row|Rows]):-
  atomic_list_concat(Row, TRow),
  writeln(TRow),
  print_matrix(Rows).

print([]).
print([[_,_,Row|_]|Rows]):- write(Row), print(Rows).

%Elimina un elemento segun la posicion N indicada.
remove(N, L, L):- N =< 0.
remove(1, [_|T], T):- !.
remove(N, [H|T1], [H|T2]):- N > 1, N1 is N - 1, remove(N1, T1, T2).

third([], []):- !.
third([[_, _, Third|_]| Xs], [Third| Ys]):- third(Xs, Ys), !.

rgb([], []):- !.
rgb([[_, _, R, G, B|_]| Xs], [R, G, B|Ys]):- rgb(Xs, Ys), !.

printMatrix_([], _, _).
printMatrix_([X|Xs], Before, After) :-
    write(Before),
    (X = [_|_] ->   
        printMatrix_(X, '', '')
    ;   write(X)),
    write(After),
    (Xs = [] -> true ; write(',')),
    printMatrix_(Xs, Before, After).

printMatrix1(Mx) :-
    write('{'),
    printMatrix_(Mx, '{', '}'),
    write('}').



printMatrix([]):- !.
printMatrix([M|Mt]):- printMatrixln(M), nl, printMatrix(Mt).
printMatrixln([]):- !.
printMatrixln([L|Lt]):- write(L), write(' '), printMatrixln(Lt).

do_line(0,_):-nl.
do_line(N, [[_, _, P|_]|T]):-
  N > 0,
  write(P),
  N1 is N-1,
  do_line(N1,T), !.

%do_line(N, [[_, _, P|_]|T]):- (N > 0 -> (write(P), N1 is N - 1, do_line(N1, T)); nl).

do_lines(0,_,_):- !.
do_lines(M,N,C):- M > 0,
  do_line(N,C),
  M1 is M-1,
  do_lines(M1,N,C), !.

write_square(N,C):- do_lines(N,N,C).


split_list(_, [], [[], []]):- !.
split_list(0, T, [[], T]):- !.
split_list(N, [H|T], [[H|Y], Z]):- N1 is N-1, split_list(N1, T, [Y, Z]).

%third([[0,0,1,10],[0,1,0,20],[1,0,1,30],[1,1,1,40]], L), split_list(2, L, L1), printMatrix(L1).
%1 0 
%1 1 
%L = [1, 0, 1, 1],
%L1 = [[1, 0], [1, 1]].

%writef("5\t4").
%5       4

%writef("00\t01\n10\t11").
%00      01
%10      11

%atom_concat(R1, " ", R2), atom_concat(G1, " ", G2), atom_concat(B1, "", B2), string_concat(R2, G2, RG), 
%string_concat(RG, B2, RGB),
/*========================================================================================================================================*/


/*
DOMINIOS
Width, Height, X, Y, Value, R, G, B, 
Pixel, Pixels, PixelStr, PixelsStr, Out, Image, ImageStr

REGLAS
pixelToString/6, rgbToString/8, pixelsToString/4, imageToString/2.

META PRINCIPAL
imageToString/2.

METAS SECUNDARIAS
pixelToString/6, rgbToString/8, pixelsToString/4.
*/


/*================================================== CODIGO ==========================================================================*/
%pixelToString(Width, Height, X, Y, Value, Out):- number_string(Value, Str),
%  (X < Width, Y < Height - 1 -> atom_concat(Str, "\t", Out); atom_concat(Str, "\n", Out)).


%pixelToString(Width, Height, X, Y, Value, Out):- 
%  (X < Width, Y < Height - 1 -> atom_concat(Value, "\t", Out); atom_concat(Value, "\n", Out)).

%Compuebo si Value es un numero => pixbit. Si Value no es numero => pixhex.
pixelToString(Width, Height, X, Y, Value, Out):- (number(Value) -> (number_string(Value, Str) -> 
  (X < Width, Y < Height - 1 -> atom_concat(Str, "\t", Out); atom_concat(Str, "\n", Out)));
  (X < Width, Y < Height - 1 -> atom_concat(Value, "\t", Out); atom_concat(Value, "\n", Out))).


rgbToString(Width, Height, X, Y, R, G, B, Out):- number_string(R, R1), number_string(G, G1), number_string(B, B1),
  atomic_list_concat(['[', R1, ' ', G1, ' ', B1, ']'], RGB),   
  (X < Width, Y < Height - 1 -> atom_concat(RGB, "\t", Out); atom_concat(RGB, "\n", Out)).


pixelsToString(_, _, [], []).
pixelsToString(Width, Height, [Pixel|Pixels], [PixelStr|PixelsStr]):- (pixbit(X, Y, Bit, _, Pixel) -> 
  (pixelToString(Width, Height, X, Y, Bit, PixelStr), pixelsToString(Width, Height, Pixels, PixelsStr)); 
  pixrgb(X, Y, R, G, B, _, Pixel), rgbToString(Width, Height, X, Y, R, G, B, PixelStr), pixelsToString(Width, Height, Pixels, PixelsStr)).


imageToString(Image, ImageStr):- image(Width, Height, Pixels, Image),
  pixelsToString(Width, Height, Pixels, PixelsStr), atomic_list_concat(PixelsStr, ImageStr).
/*=======================================================================================================================================*/


/*============================================= PRUEBAS Y RESULTADOS =====================================================================*/
%pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
%imageToString(I, IString), writef(IString).
%0       0
%1       1
%P1 = [0, 0, 0, 10],
%P2 = [0, 1, 0, 20],
%P3 = [1, 0, 1, 30],
%P4 = [1, 1, 1, 40],
%I = [2, 2, [[0, 0, 0, 10], [0, 1, 0, 20], [1, 0, 1|...], [1, 1|...]]],
%IString = '0\t0\n1\t1\n'.


%pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "C0C0C0", 20, P2), pixbit(1, 0, "E6E6E6", 30, P3), pixbit(1, 1, "F0F0F0", 40, P4),
%image(2, 2, [P1, P2, P3, P4], I), imageToString(I, IString), writef(IString).
%FFFFFF  C0C0C0
%E6E6E6  F0F0F0
%P1 = [0, 0, "FFFFFF", 10],
%P2 = [0, 1, "C0C0C0", 20],
%P3 = [1, 0, "E6E6E6", 30],
%P4 = [1, 1, "F0F0F0", 40],
%I = [2, 2, [[0, 0, "FFFFFF", 10], [0, 1, "C0C0C0", 20], [1, 0, "E6E6E6"|...], [1, 1|...]]],
%IString = 'FFFFFF\tC0C0C0\nE6E6E6\tF0F0F0\n'.


%pixrgb(0, 0, 200, 200, 200, 10, P1), pixrgb(0, 1, 210, 210, 210, 20, P2), pixrgb(1, 0, 220, 220, 220, 30, P3), 
%pixrgb(1, 1, 230, 230, 230, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageToString(I, IString), writef(IString).
%[200 200 200]   [210 210 210]
%[220 220 220]   [230 230 230]
%P1 = [0, 0, 200, 200, 200, 10],
%P2 = [0, 1, 210, 210, 210, 20],
%P3 = [1, 0, 220, 220, 220, 30],
%P4 = [1, 1, 230, 230, 230, 40],
%I = [2, 2, [[0, 0, 200, 200, 200|...], [0, 1, 210, 210|...], [1, 0, 220|...], [1, 1|...]]],
%IString = '[200 200 200]\t[210 210 210]\n[220 220 220]\t[230 230 230]\n'.
/*=======================================================================================================================================*/