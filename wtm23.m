function wtm23(mem, steps, init)
if nargin<3, init=0; end
clc, close all
% arithmetized transition map for Wolfram's minimal (2, 3)-TM
v = [ 0 1 13 13 6 6 4 4 8 9 6 6 15 15 3 3]; 
%bar(v), title('Arithmetized Transition Table'), pause
% generate initial random string
u = [(2:7), (10:15)]; % ommit idle states (fixed points)
p=floor(mem/2);mat=[];
if init
    t = u( randint(1, mem, [1, 12] ) );
else
    t = 3*ones(1, mem); t(p) = 13;
end
for i=1:steps 
    %disp( [p t(p)] ), pause
    p0 = p; t(p) = v( t(p) );      % update tape
    p = p + 2*mod( t(p), 2) - 1;     % update pointer
    s = ( abs( t(p) - t(p0) )>7 );     % ctrl bit correction
    s = s*( 2*( t(p) < t(p0) ) - 1 );
    t(p) = t(p) + 8*s + 1;
    mat=[mat; t];
end
imagesc(mat)
end