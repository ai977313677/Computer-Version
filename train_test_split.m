function [train, test, label_train, label_test] = train_test_split(data, label, per)
%TRAIN_TEST_SPLIT use to divide the dataset into trainset and testset and
%   return its' label.
%
%   Parameters include:
%   'data'                          the original dataset.
%   'label'                         the data's label.
%   'per'                           percentage of test data in all data.
%   
%   Example 1
%   [au_markov, au_texture] = preproc('../Au', @markov, @texturebyglcm);
%   [len, ~] = size(au_markov);
%   label = ones(len, 1);
%   per = 0.3;
%   [train, test, label_train, label_test] = train_test_split(au_markov,
%   label, per);
%
%   $ Date: 2019-6-14 09:44:20 $

[a, gT] = size(data);
trainSize = round(a*(1-per));
testSize = a-trainSize;

randSeq = randperm(a);
train = zeros(trainSize, gT);
test = zeros(testSize, gT);
label_train = zeros(trainSize, 1);
label_test = zeros(testSize, 1);

idx = 1;
for i = 1:trainSize
    pos = randSeq(idx);
    train(i, :) = data(pos, :);
    label_train(i, :) = label(pos, :);
    idx = idx+1;
end

for i = 1:testSize
    pos = randSeq(idx);
    test(i, :) = data(pos, :);
    label_test(i, :) = label(pos, :);
    idx = idx+1;
end
end