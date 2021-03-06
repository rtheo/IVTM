function Rstats(R, n, m, ntype)
% R:: Rule sequence for ACA equivalent of Wolfram (2,3)-TM
% n:: number of random points
% m:: number of histogram bins
% ntype:: (0) flat noise, (1) Gaussian  (2) Brownian
clc, close all
if mod(n, 3)~=0, n=n-mod(n,3);end, newdim=floor(n/3);
switch ntype
    case 0, vo = floor( 16*rand(1,n) ); % flat noise
    case 1, vo = randn(1, n);           % gaussian noise
    case 2, vo = cumsum( rand(1,n) - 0.5 ); % simplified Brownian
end
if ntype>0
    vo = vo + abs(min(vo)) + 1; % rescale to extract 4-bit integers
    vo = vo/(max(vo)+1);
    vo = floor( 16*vo ) ; 
end
vo = reshape(vo, 3, newdim); 
rs = R(  vo(1, :)+16*vo(2, :) + 1 ); 
s = abs( rs - vo(3, :) ) == 0; % matching filter
[cd cv] = clusters(s); cc = -cv(cv<0);
%hist(cc, m)
figure(1), h=hist(cc, m); title(['Tansition Intervals.: ',num2str(cd)])
figure(2), loglog(1:length(h), h) 
end
