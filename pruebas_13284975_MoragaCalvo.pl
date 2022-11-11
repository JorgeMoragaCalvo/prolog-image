% Scripts de PRUEBAS

% ======================================================
%                       pixbit
%                       pixrgb
%                       pixhex
%                       image
% ======================================================

pixbit(0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 40, PD), image(2, 2, [PA, PB, PC, PD], I).

pixhex(0, 0, "FAFAFA", 10, PA), pixhex(0, 1, "C8C8C8", 20, PB), pixhex(1, 0, "E6E6E6", 30, PC), pixhex(1, 1, "FFFFFF", 40, PD),
image(2, 2, [PA, PB, PC, PD], I).

pixrgb( 0, 0, 10, 10, 10, 10, P1), pixrgb( 0, 1, 20, 20, 20, 20, P2), pixrgb( 1, 0, 30, 30, 30, 30, P3), pixrgb( 1, 1, 40, 40, 40, 40, P4), 
image(2, 2, [P1, P2, P3, P4], I).



% ======================================================
%                       imageIsBitmap
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I),
imageIsBitmap(I).

pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 2, 40, P3), pixbit(1, 1, 0, 40, P4), image(2, 2, [P1, P2, P3, P4], I),
imageIsBitmap(I).
%false. El Bit del Pixel 3, no es ni 0 ni 1.

pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 1, 20, P2), pixbit(1, 0, 1, 40, P3), pixbit(-1, 1, 0, 40, P4),image(2, 2, [P1, P2, P3, P4], I),
imageIsBitmap(I).
%false. La coordenada X del Pixel 4 es negativa.



% ======================================================
%                       imageIsPixmap
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 4, PD), 
image(2, 2, [PA, PB, PC, PD], I), imageIsPixmap(I).
%false

pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
pixrgb(1, 1, 240, 240, 240, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%True

pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
pixrgb(1, 1, 256, 256, 256, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%false. En el Pixel 4, los canales RGB exceden en 1 el valor maximo.

pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 250, 250, 250, 20, P2),pixrgb(1, 0, 245, 245, 245, 30, P3),
pixrgb(1, -1, 240, 240, 240, 40, P4),image(2, 2, [P1, P2, P3, P4], I), imageIsPixmap(I).
%false. El "alto" del Pixel 4 es negativo.



% ======================================================
%                       imageIsHexmap
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 4, PD), 
image(2, 2, [PA, PB, PC, PD], I), imageIsHexmap(I).
%false

pixhex(0, 0, "FAFAFA", 10, P1), pixhex(0, 1, "FFFFFF", 20, P2), pixhex(1, 0, "FAFAFA", 30, P3), pixhex(1, 1, "FFFFFF", 40, P4), 
image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%True.

pixhex(0, 0, "C8C8C8", 10, P1), pixhex(0, 1, "E5E5E5", 20, P2), pixhex(1, 0, 3, 30, P3), 
pixhex(1, 1, "C8C8C8", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%false. El color del Pixel 3 no es un string.

pixhex(0, 0, "F6F6F6", 10, P1), pixhex(0, 1, "FAFAFA", 20, P2), pixhex(-1, 0, "FFFFFF", 30, P3), 
pixhex(1, 1, "E6E6E6", 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageIsHexmap(I).
%false. La coordenada X del Pixel 3 es negativa.



% ======================================================
%                       imageIsCompressed
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 40, PD), 
image(2, 2, [PA, PB, PC, PD], I), imageIsCompressed(I).
%false

pixhex(0, 0, "#F0F0F0", 10, P1), pixhex(0, 1, "#F0F0F0", 20, P2), pixhex(1, 0, "#F0F0F0",30, P3), pixhex(1, 1, "#F0F0F0", 10, P4),
image(2, 2,[P1, P2, P3, P4],I), imageIsCompressed(I).
%false.

pixrgb(0, 0, 255, 255, 255, 10, P1), pixrgb(0, 1, 255, 255, 255, 20, P2), pixrgb(1, 0, 255, 255, 255, 30, P3), 
pixrgb(1, 1, 255, 255, 255, 10, P4), image(2, 2,[P1, P2, P3, P4], I), imageIsCompressed(I).
%false.



% ======================================================
%                       imageFlipH
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 40, PD),
image(2, 2, [PA, PB, PC, PD], I), imageFlipH(I, I2).

pixhex(0, 0, "#FFFFFF", 10, P1), pixhex(0, 1, "#FFFFFF", 20, P2), pixhex(1, 0, "#FFFFFF", 30, P3), pixhex(1, 1, "#FFFFFF", 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageFlipH(I, I1).


pixrgb(0, 0, 210, 210, 210, 10, P1), pixrgb(0, 1, 220, 220, 220, 20, P2), pixrgb(1, 0, 230, 230, 230, 30, P3),
pixrgb(1, 1, 240, 240, 240, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageFlipH(I, I1).

pixhex(0, 0, "0A0A0A", 13, P1), pixhex(0, 1, "141414", 24, P2), pixhex(0, 2, "0A0A0A", 1, P3), pixhex(1, 0, "1E1E1E", 330, P4),
pixhex(1, 1, "282828", 20, P5), pixhex(1, 2, "1E1E1E", 35, P6), pixhex(2, 0, "1E1E1E", 3, P7), pixhex(2, 1, "1E1E1E", 6, P8),
pixhex(2, 2, "1E1E1E", 66, P9), image(3, 3,[P1, P2, P3, P4, P5, P6, P7, P8, P9], I), imageFlipH(I, I1).



% ======================================================
%                       imageFlipV
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 40, PD),
image(2, 2, [PA, PB, PC, PD], I), imageFlipV(I, I2).

pixhex(0, 0, "0A0A0A", 13, P1), pixhex(0, 1, "141414", 24, P2), pixhex(0, 2, "0A0A0A", 1, P3), pixhex(1, 0, "1E1E1E", 330, P4),
pixhex(1, 1, "282828", 20, P5), pixhex(1, 2, "1E1E1E", 35, P6), pixhex(2, 0, "1E1E1E", 3, P7), pixhex(2, 1, "1E1E1E", 6, P8),
pixhex(2, 2, "1E1E1E", 66, P9), image(3, 3,[P1, P2, P3, P4, P5, P6, P7, P8, P9], I), imageFlipV(I, I1).

pixrgb(0, 0, 210, 210, 210, 10, P1), pixrgb(0, 1, 220, 220, 220, 20, P2), pixrgb(1, 0, 230, 230, 230, 30, P3),
pixrgb(1, 1, 240, 240, 240, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageFlipV(I, I1).



% ======================================================
%                       imageCrop
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
imageCrop(I, -1, -1,0.5, 0.5,I1).

pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
imageCrop(I, 0.5, 0.5, 2, 2 ,I1).

pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "0A0A0A", 20, P2), pixhex(1, 0, "C8C8C8", 30, P3), pixhex(1, 1, "E3E3E3", 40, P4), 
image(2, 2,[P1, P2, P3, P4], I), imageCrop(I, 0.5, 0.5, 2, 2 ,I1).



% ======================================================
%                       imageRGBToHex
% ======================================================
pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2), pixrgb(1, 0, 30, 30, 30, 30, P3), pixrgb(1, 1, 40, 40, 40, 40, P4), 
image(2, 2,[ P1, P2, P3, P4], I1), imageRGBToHex(I1, I2).

pixrgb(0, 0, 220, 220, 220, 10, P1), pixrgb(0, 1, 230, 230, 230, 20, P2), pixrgb(1, 0, 240, 240, 240, 30, P3), 
pixrgb(1, 1, 250, 250, 250, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1).

pixrgb(0, 0, 110, 110, 110, 10, P1), pixrgb(0, 1, 120, 120, 120, 20, P2), pixrgb(1, 0, 130, 130, 130, 30, P3), pixrgb(1, 1, 140, 140, 140, 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1).

pixrgb(0, 0, 70, 70, 70, 10, P1), pixrgb(0, 1, 80, 80, 80, 20, P2), pixrgb(1, 0, 90, 90, 90, 30, P3), pixrgb(1, 1, 100, 100, 100, 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageRGBToHex(I, I1).



% ======================================================
%                       imageToHistogram
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I), 
imageToHistogram(I, I1).

pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FFFFFF", 20, P2), pixbit(1, 0, "FFFFFF", 30, P3), pixbit(1, 1, "A0A0A0", 40, P4), 
image(2, 2, [P1, P2, P3, P4], I), imageToHistogram(I, I1).

pixrgb(0, 0, 0, 0, 0, 10, P1), pixrgb(0, 1, 10, 10, 10, 20, P2),  pixrgb(1, 0, 20, 20, 20, 30, P3), pixrgb(1, 1, 30, 30, 30, 40, P4), 
image(2, 2, [P1, P2, P3, P4], I), imageToHistogram(I, I1).



% ======================================================
%                       imageRotate90
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I), 
imageRotate90(I, I1).

pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "F0F0F0", 20, P2), pixbit(1, 0, "FFFFFF", 30, P3), pixbit(1, 1, "F0F0F0", 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageRotate90(I, I1); true.

pixrgb(0, 0, 0, 0, 0, 10, P1), pixrgb(0, 1, 10, 10, 10, 20, P2),  pixrgb(1, 0, 20, 20, 20, 30, P3), pixrgb(1, 1, 30, 30, 30, 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageRotate90(I, I1).



% ======================================================
%                       imageCompress
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
imageCompress(I, I1).

pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 30, 30, 30, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
image(2, 2,[P1, P2, P3, P4], I), imageCompress(I, I1).

pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FAFAFA", 20, P2), pixhex(1, 0, "FFFFFF", 30, P3), pixhex(1, 1, "FFFFFF", 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageCompress(I, I1).



% ======================================================
%                       imageChangePixel
% ======================================================
%Modifica el pixel 2 de una imagen pixrgb
pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
image(2, 2, [P1,P2,P3,P4], I), pixrgb(0, 1, 54, 54, 54, 20, P2_Modificado), imageChangePixel(I, P2_Modificado, I2).

%Modifica el pixel 4 de una imagen pixbit
pixbit(0, 0, 1, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 0, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2, [P1, P2, P3, P4], I), 
pixbit(1, 1, 0, 50, P4_Modificado), imageChangePixel(I, P4_Modificado, I2).

%Modifica el pixel 3 de una imagen pixhex
pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "E1E1E1", 20, P2), pixhex(1, 0, "FFFFFF", 30, P3), pixhex(1, 1, 1, "FFFFFF", P4),
image(2, 2, [P1,P2,P3,P4], I), pixhex(1, 0, "C8C8C8", 50, P3_Modificado), imageChangePixel(I, P3_Modificado, I2).



% ======================================================
%                       imageInvertColorRGB
% ======================================================
%Se modifica el segundo pixel.
pixrgb(0, 0, 10, 10, 10, 10, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
image(2, 2, [P1,P2,P3,P4], I), imageInvertColorRGB(P2, P2_Modificado), imageChangePixel(I, P2_Modificado, I2).

%Se modifica el primer pixel.
pixrgb(0, 0, 0, 0, 0, 0, P1), pixrgb(0, 1, 20, 20, 20, 20, P2),pixrgb(1, 0, 30, 30, 30, 30, P3),pixrgb(1, 1, 40, 40, 40, 40, P4),
image(2, 2, [P1,P2,P3,P4], I), imageInvertColorRGB(P1, P1_Modificado), imageChangePixel(I, P1_Modificado, I2).

%Se modifica el ultimo pixel.
pixrgb(0, 0, 0, 0, 0, 0, P1), pixrgb(0, 1, 20, 20, 20, 20, P2), pixrgb(1, 0, 30, 30, 30, 30, P3), pixrgb(1, 1, 40, 40, 40, 40, P4), 
image(2, 2, [P1, P2, P3, P4], I), imageInvertColorRGB(P4, P4_Modificado), imageChangePixel(I, P4_Modificado, I2).


% ======================================================
%                       imageToString
% ======================================================
pixbit(0, 0, 0, 10, P1), pixbit(0, 1, 0, 20, P2), pixbit(1, 0, 1, 30, P3), pixbit(1, 1, 1, 40, P4), image(2, 2,[P1, P2, P3, P4], I),
imageToString(I, IString), writef(IString).

pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "C0C0C0", 20, P2), pixbit(1, 0, "E6E6E6", 30, P3), pixbit(1, 1, "F0F0F0", 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageToString(I, IString), writef(IString).

pixrgb(0, 0, 200, 200, 200, 10, P1), pixrgb(0, 1, 210, 210, 210, 20, P2), pixrgb(1, 0, 220, 220, 220, 30, P3), 
pixrgb(1, 1, 230, 230, 230, 40, P4), image(2, 2, [P1, P2, P3, P4], I), imageToString(I, IString), writef(IString).


% ======================================================
%                       imageDepthLayers
% ======================================================
pixbit(0, 0, 1, 10, PA), pixbit(0, 1, 0, 20, PB), pixbit(1, 0, 0, 30, PC), pixbit(1, 1, 1, 10, PD), 
image(2, 2, [PA, PB, PC, PD], I), imageDepthLayers(I, LI).


pixhex(0, 0, "FFFFFF", 10, P1), pixhex(0, 1, "FAFAFA", 20, P2), pixhex(1, 0, "FFFFFF", 30, P3), pixhex(1, 1, "FFFFFF", 40, P4),
image(2, 2, [P1, P2, P3, P4], I), imageDepthLayers(I, I1).

pixrgb(0,0,10,10,10,10,P1), pixrgb(0,1,20,20,20,20,P2), pixrgb(1,0,30,30,30,30,P3), pixrgb(1,1,40,40,40,40,P4),
image(2,2,[P1,P2,P3,P4],I), imageDepthLayers(I, I1).