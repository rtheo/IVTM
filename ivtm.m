function ivtm(R, mem, steps, init, ntype, nbins)
% R:: equivalent ACA rule
% mem:: total tape length
% steps:: length of random trajectory
% init::   initialize (0) single cell vs (1) random string across tape
% ntype:: select noise source
% nbins:: no. of bins for final histogram
if nargin<6, nbins = 100; end
if nargin<5, ntype = 0; end
if nargin<4, init = 0; end
clc, close all
u = [(2:7), (10:15)]; % ommit idle states (fixed points)
p=floor(mem/2);
if init
    t = u( randint(1, mem, [1, 12] ) );
else
    t = 3*ones(1, mem); t(p) = rand;
end
switch ntype
    case 0, rn = floor(16*rand(1,steps)); % flat noise
    case 1, rn = randn(1, steps);           % gaussian noise
    case 2, rn = cumsum( rand(1, steps) - 0.5 ); % simplified Brownian               
end
if type>0,  rn = rn + abs(min(rn)) + 1; rn = rn/(max(rn)+1); rn = floor( 16*rn ); end % rescale to 4-bits
k = 1; p0 = p; 
wt = zeros(1, steps); % waiting times record
ptr = wt;
for i=1:steps
    [t, p, p0, m] = tm2aca(R, t, p, p0, rn(i)); % the machine kernel + matching filter
    if m, 
        k=k+1; wt(k) = 1;
    else
        wt(k) = wt(k) + 1; 
    end
end
hist(wt(1:k), nbins) 
title(['waiting times distribution. Total transitions: ', num2str(k)])
end