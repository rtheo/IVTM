k = 0; R = [];
T = [ 0 1 13 13 6 6 4 4 8 9 6 6 15 15 3 3]; 
for i=0:15
    for j=0:15
        s = ( abs( i - j )>7 );     
        s = s*( 2*( i < j ) - 1 );
        R = [R, T( i + 8*s + 1 ) ];
    end
end
%bar(R)
plot(R), hold on,plot(R,'*r'), hold off