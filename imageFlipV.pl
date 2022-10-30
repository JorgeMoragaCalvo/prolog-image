/*
:- module(imageFlipV, [imageFlipV/2]).
*/

%Girar la imagen verticalmente
%Input
%2 * 2
%PA(0, 0)  PB(0, 1)
%PC(1, 0)  PD(1, 1)

%Output
%2 * 2
%PC(0, 0)  PD(0, 1)
%PA(1, 0)  PB(1, 1)

%PA(0, 0) -> (1, 0) -> X - 1
%PB(0, 1) -> (1, 1) -> X - 1
%PC(1, 0) -> (0, 0) -> X + 1
%PD(1, 1) -> (0, 1) -> X - 1

