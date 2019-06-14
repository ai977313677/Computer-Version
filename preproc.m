function [mrkv, texture] = preproc(path, varargin)
%PREPROC get dataset, extra the feature from pictures and store it into
%   mrkv(markov feature) , texture(texture feature).
%   use it like x = preproc('C:\pic\', @markov);
%
%   Parameters include:
%   'path'                     the set of pictures.
%   'varargin'                 the handle of function, like @markov
%
%   $ Date:2019-6-14 09:48:54 $

addpath(genpath('./'));

n = numel(varargin);
if n == 0
    return ;
else
    for i = 1:n
        varname = func2str(varargin{i});
        fun = varargin{i};
        eval([varname '=fun;']);
    end
end

if ~exist(path, 'dir')
    fprintf('no dir: %s\n', path);
end

list = dir(path); list = list(3:end);
[len, ~] = size(list);

n = 8; T = 5; N = (2*T+1)*(2*T+1)*4;
mrkv = zeros(len, N);
texture = zeros(len, 16);
for i = 1:len
    fname = [list(i).folder, '\', list(i).name];
    img = imread(fname);
    ycbcr = rgb2ycbcr(img);
    y = ycbcr(:,:,1);
    if exist('markov', 'var')
        [Ph, Pv, Pd, Pm] = markov(y, n, T);
        mrkv(i,:) = [Ph, Pv, Pd, Pm];
    end
    if exist('texturebyglcm', 'var')
        [Con, Cor, Ene, Homo] = texturebyglcm(y);
        texture(i,:) = [Con, Cor, Ene, Homo];
    end
end
end