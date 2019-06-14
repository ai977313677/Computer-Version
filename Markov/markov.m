function [Ph, Pv, Pd, Pm] = markov(img, n, T)
%MARKOV markov based feature
%   markov(img, n, T) returns four direction's feature(horizontal (h), 
%   vertical (v), diagonal (d), and minor-diagonal (m))
%   
%   Parameters include:
%   'img'           a Pixel 2D-Array (rgb or gray)
%   'n'             Block size; markov use the Multi-Block Discret Cosine
%                   Transfoem.
%   'T'             threhold; Simplify the computing...
%   
%   Example 1
%   img = imread('circle.TIF');
%   n = 8; T = 5;
%   [Ph, Pv, Pd, Pm] = markov(img, n, T)
%
%   $Date: 2019-6-12 13:35:03 $

gray = img;
if numel(size(img))>2
    gray = rgb2gray(img);
end

%% n¡Án DCT
fun = @(block_struct)dct2(block_struct.data);
bdct = blockproc(gray, [n n], fun);

%% round coefficents to a nearest integers, and then obtain the integers' absolute values
bdct = abs(round(bdct));

%% cal the difference 2-D array
Fh = diff(bdct);
Fv = diff(bdct, 1, 2);
[Su, Sv] = size(gray);
Fd = zeros(Su-1, Sv-1);
Fm = zeros(Su-1, Sv-1);
for i = 1:Su-1
    for j = 1:Sv-1
        Fd(i, j) = bdct(i, j)-bdct(i+1, j+1);
        Fm(i, j) = bdct(i+1, j)-bdct(i, j+1);
    end
end

%% Threholding
Fh(Fh>T) = T; Fh(Fh<-T) = -T;
Fv(Fv>T) = T; Fv(Fv<-T) = -T;
Fd(Fd>T) = T; Fd(Fd<-T) = -T;
Fm(Fm>T) = T; Fm(Fm<-T) = -T;

%% Transition Probablity Matrix
[Ph, Pv, Pd, Pm, N] = transprob(Fh, Fv, Fd, Fm, T);
Ph = reshape(Ph', 1, N*N);
Pv = reshape(Pv', 1, N*N);
Pd = reshape(Pd', 1, N*N);
Pm = reshape(Pm', 1, N*N);
end