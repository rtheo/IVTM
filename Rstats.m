function Rstats(R, n, m)
% R:: Rule sequence for ACA equivalent of Wolfram (2,3)-TM
% n:: number of random points
% m:: number of histogram bins
clc, close all
%vo = floor(8*(rand(1,n)+1)); % flat noise
vo = cumsum( rand(1,n) - 0.5 ); % Brownian noise
vo = vo + abs(min(vo)) + 1; vo = vo/(max(vo)+1);
vo = floor( 16*vo ) ;
%plot(vo), pause
rs = R(  vo(1:end-2)+16*vo(2:end-1) + 1 ); % matching filter
s = abs( rs - vo(3:end) ) < 1/16;
[cd cv] = clusters(s); cc = -cv(cv<0);
figure(1), h=hist(cc, m); title(['Tansition Intervals.: ',num2str(cd)]), pause
figure(2), loglog(1:length(h), h)
end