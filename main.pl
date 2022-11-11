:- use_module(pixbit).
:- use_module(pixrgb).
:- use_module(pixhex).
:- use_module(image).
:- use_module(imageIsBitmap).
:- use_module(imageIsPixmap).
:- use_module(imageIsHexmap).
:- use_module(imageIsCompressed).
:- use_module(imageFlipH).
:- use_module(imageFlipV).
:- use_module(imageCrop).
:- use_module(imageRGBToHex).
:- use_module(imageToHistogram).
:- use_module(imageRotate90).
:- use_module(imageInvertColorRGB).
:- use_module(imageCompress).
:- use_module(imageChangePixel).
:- use_module(imageInvertColorRGB).
:- use_module(imageToString).
:- use_module(imageDepthLayers).

%toHex(X, N):- toHexProof1(X, N1), toHexProof2(X, N2), string_concat(N1, N2, N).

whatIs(I):- (imageIsBitmap(I) -> display("Is pixbit"); (imageIsHexmap(I) -> display("Is pixhex"); display("error"))).
