%{
MDS: multiple dimension scaling

input:
    x:reach column is a data vector(n dimension)
    k: transform data into m dimension (k <= n)
output:
    Y: y = eig_vectors * x , thre transform result
    eig_vectors: the dimension transform metric
%}
function [Y,egi_vectors] = function_MDS(x,k)
    n = size(x,2);
    if k > n
        sprintf('%s','error k must less than vector x dimension!')
        exit
    end
    % caculate dist_2(i,j) for each i,j in 1,2....n
    dist_2 = zeros(n,n);
    for i = 1 : n
        for j = 1 : n
            dist_2(i,j) = x(1,i)' * x(1,j);
        end
    end
    % calculate b(i,j)
    b = zeros(n,n);
    m = mean(mean(dist_2)) / n;
    for i = 1 : n
        for j = 1 : n
            b(i,j) = -0.5 * (dist_2(i,j) + m - mean(dist_2(i,:)) - mean(dist_2(j,:)));
        end
    end
    % eigent values and vectors
    [egi_vectors,egi_values]=eig(cov(x'));
    [value_sort,sort_index]=sort(diag(egi_values),'descend');
    egi_vectors = egi_vectors(:,sort_index);
    egi_vectors = egi_vectors(:,1:k)
    Y =egi_vectors'*x;
end