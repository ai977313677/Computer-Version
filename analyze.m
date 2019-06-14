function [TPR,FNR,FPR,TNR,P,N] = analyze(label, pre)
%ANALYZE cal the TPR, FNR, FPR, TNR, count the Positive and Negative
%   content.
%
%   Parameters include:
%   'label'                     original data label.
%   'pre'                       predict data label.
%   
%   $ Date: 2019-6-14 09:48:13 $
[a,~] = size(label);
TP = 0; FN = 0; FP = 0; TN = 0; P = 0; N = 0;
for i = 1:a
    if label(i)==1
        P = P+1;
    end
    if label(i)==-1
        N = N+1;
    end
    if label(i)==1&&pre(i)==1
        TP = TP+1;
    end
    if label(i)==1&&pre(i)==-1
        FN = FN+1;
    end
    if label(i)==-1&&pre(i)==-1
        TN = TN+1;
    end
    if label(i)==-1&&pre(i)==1
        FP = FP+1;
    end
end

TPR = TP/(TP+FN);
FNR = FN/(FN+TP);
FPR = FP/(FP+TN);
TNR = TN/(TN+FP);
end