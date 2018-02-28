%{
KL trnasform(PCA)
%}
function [egi_vectors,Y] = function_KL_transform_PCA(X,k)
if k > size(X,1)
    sprintf('%s','error k must less than vector x‘s dimension!')
    return
end
cov(X')
[egi_vectors,egi_values]=eig(cov(X'))
[value_sort,sort_index]=sort(diag(egi_values),'descend')
egi_vectors=egi_vectors(:,sort_index)
egi_vectors=egi_vectors(:,1:k)
Y=egi_vectors'*X
end

