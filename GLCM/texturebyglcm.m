function [Contrast, Correlation, Energy, Homogeneity] = texturebyglcm(img)
%TEXTUREBYAPI cal the Texture Feature by GLCM, use Matlab API
%   TextureByGLCM(img) returns four features:Contrast, Correlation, Energy, Homogeneity
%   
%   Parameter include:
%   'img'       img = imread(file); it convert rgb to grayscale image.
%   
%   Example 1
%   img = imread('circle.TIF');
%   [Con, Cor, Ene, Homo] = texturebyglcm(img);
%   $Date: 2019-6-13 22:45:28 $

gray = img;
if numel(size(img))>2
    gray = rgb2gray(img);
end

% d=1, angle=0,45,90,135
[glcm, ~] = graycomatrix(gray, 'NumLevels', 8, 'GrayLimit', [], 'Offset', [0 1;-1 1;-1 0;-1 -1], 'Symmetric', true);
stats = graycoprops(glcm, 'all');

% Feature:[Contrast, Correlation, Energy, Homogeneity]
Contrast = stats.Contrast;
Correlation = stats.Correlation;
Energy = stats.Energy;
Homogeneity = stats.Homogeneity;

end