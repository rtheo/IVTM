function [T, p, pold, Match] = tm2aca(R, T, p, pold, inp)
% R::  Rule for asynchronous CA
% T:: "Tape"/memory structure
% Match:: flag for matching filter
Tr = R(  T(p)+16*T(pold) + 1 ); 
Match = abs( Tr - inp ) == 0; 
if Match
    T(p) = Tr;
    pold = p; p = p + 2*mod(T(p), 2) - 1;
end
end