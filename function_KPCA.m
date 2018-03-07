%{
KPCA:kernal PCA

input:
    X : each column is a data(dimension is n)
    k : the target dimension 

output:
    Y: the new dimension values
%}
function [Y] = function_KPCA(X,k)
    N = size(X,2);
    n = size(X,1);
    if k > N
        sprintf('%s','error k must less than vector x‘s dimension!')
        exit
    end
    
    %caculate the kernal
    K = zeros(N,N);
    for i = 1 :N
       for j = 1 : N
          %linear kernal
          %K(i,j) = X(:,i)' * X(:,j); 

          %gaussian kernal
          K(i,j) = exp(-sqrt((X(:,i) - X(:,j))' * (X(:,i) - X(:,j)))/2/100);
       end
    end
    
    %caculate K's eigent values and vectors,keep k largest eigent values
    [V,lambda] = eig(K);
    [lambda,sort_index]=sort(diag(lambda),'descend');
    V=V(:,sort_index);
    V=V(:,1:k);
    
    %caculate the transformed value
    Y = zeros(k,N);
    for i = 1 : N
        for j = 1 : k
            Y(j,i) = V(:,j)' * K(:,i) / sqrt(lambda(j,1));
        end
    end
end