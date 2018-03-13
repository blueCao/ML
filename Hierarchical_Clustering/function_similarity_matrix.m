%{
caculate the two foods p,q similarity

input :
    X:  mxN,    each column is a data(m dimensions)

output:
    sim: NxN,   similarity of each foods

output:


%}
function [ sim ] = function_similarity( X )
    m = size(X,1);
    N = size(X,2);
    sim = zeros(N,N);
    
    for p = 1 : N
       Xp = X(:,p);
       for q = 1 : N
              Xq = X(:,q);
              tmp = min(Xp,Xq) ./ max(Xp,Xq);
              tmp(isnan(tmp)) = 1;
              sim(p,q) = sum(tmp) / m;
       end
    end
end

