%{
caculate the two cluster foods p,q similarity

input :
    Xp:  mxN,    each column is a data(m dimensions)
    Xq:  mxN,    each column is a data(m dimensions)

output:
    sim:,   similarity of the two foods Xp, Xq


%}
function [ sim ] = function_similarity_p_q( Xp, Xq )
    if size(Xp,1) ~= size(Xq,1)
        disp('Xp Xq should has the same dim');
    end
    
    m = size(Xp,1);
    sim = 0;
    
    tmp = min(Xp,Xq) ./ max(Xp,Xq);
    tmp(isnan(tmp)) = 1;
    sim = sum(tmp) / m;
end

