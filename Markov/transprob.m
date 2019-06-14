function [Ph, Pv, Pd, Pm, N] = transprob(Fh, Fv, Fd, Fm, T)
%TRANSPROB cal the Transition probablity matrix(Ph, Pv, Pd, Pm)
%   
%   Parameters include:
%   'Fh,Fv,Fd,Fm'               four direction's Difference 2-D arrays.
%   'T'                         threhold
%
%   $Date: 2019-6-12 13:35:03 $

    N = 2*T+1;
    Ph = zeros(N, N);
    Pv = zeros(N, N);
    Pd = zeros(N, N);
    Pm = zeros(N, N);
    offset = T+1;
    
    % row = Su, col = Sv
    [Su, Sv] = size(Fh);
    for m = -T:T % Ph
        mx = m+offset;
        for n = -T:T
            ny = n+offset;
            up = 0; down = 0; % up表示分子，down表示分母
            for v = 1:Sv-1
                for u = 1:Su-1
                    if Fh(u, v)==m
                        down = down+1;
                        if Fh(u+1, v)==n
                            up = up+1;
                        end
                    end
                end
            end
            if down==0
                Ph(mx, ny) = 0.00001;
            else
                Ph(mx, ny) = double(double(up)/double(down));
            end
            if Ph(mx, ny)<0.00001
                Ph(mx, ny) = 0.00001;
            end
        end
    end
    
    % row = Su, col = Sv
    [Su, Sv] = size(Fv);
    for m = -T:T % Pv
        mx = m+offset;
        for n = -T:T
            ny = n+offset;
            up = 0; down = 0;
            for v = 1:Sv-1
                for u = 1:Su-1
                    if Fv(u, v)==m
                        down = down+1;
                        if Fv(u, v+1)==n
                            up = up+1;
                        end
                    end
                end
            end
            if down==0
                Pv(mx, ny) = 0.00001;
            else
                Pv(mx, ny) = double(double(up)/double(down));
            end
            if Pv(mx, ny)<0.00001
                Pv(mx, ny) = 0.00001;
            end
        end
    end
    
    % row = Su, col = Sv
    [Su, Sv] = size(Fd);
    for m = -T:T % Pd
        mx = m+offset;
        for n = -T:T
            ny = n+offset;
            up = 0; down = 0;
            for v = 1:Sv-1
                for u = 1:Su-1
                    if Fd(u, v)==m
                        down = down+1;
                        if Fd(u+1, v+1)==n
                            up = up+1;
                        end
                    end
                end
            end
            if down==0
                Pd(mx, ny) = 0.00001;
            else
                Pd(mx, ny) = double(double(up)/double(down));
            end
            if Pd(mx, ny)<0.00001
                Pd(mx, ny) = 0.00001;
            end
        end
    end
    
    % row = Su, col = Sv
    [Su, Sv] = size(Fm);
    for m = -T:T % Pm
        mx = m+offset;
        for n = -T:T
            ny = n+offset;
            up = 0; down = 0;
            for v = 1:Sv-1
                for u = 1:Su-1
                    if Fm(u+1, v)==m
                        down = down+1;
                        if Fm(u, v+1)==n
                            up = up+1;
                        end
                    end
                end
            end
            if down==0
                Pm(mx, ny) = 0.00001;
            else
                Pm(mx, ny) = double(double(up)/double(down));
            end
            if Pm(mx, ny)<0.00001
                Pm(mx, ny) = 0.00001;
            end
        end
    end
end