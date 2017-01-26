function [cd, cv, cs, cu]=clusters(s)
% Maps the bit block structure of binary patterns 
% into a polynomial and extracts uniquenescc and
% other useful indices.
% -----------------------------------------------------
% RETURNS :
% cv : cluster vector, cd : cluster dim, cs : cumulant, cu : uniqueness
%
% Theophanes E. Raptis, DAT-NCSRD 2010
% http://cag.dat.demokritos.gr
% rtheo@dat.demokritos.gr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % change representation
    s = 2*s - 1;
    % edge detection
     v = abs(diff(s))/2;
    % cluster dimension
    cd = sum(v) + 1;
    % extract cluster polynomial coefficients
    n = length(s);
    v = [0, v]; % protect from ptr overflow     
    csum = 0; cdptr = 1;
    for j=1:n
        csum = csum + s(j) - csum*v(j);
        cdptr = cdptr + v(j);
        cv(cdptr) = csum;        
    end    
    cs = cumsum(abs(cv));
    cu = length( unique( abs(cv) ) )/cd;
end