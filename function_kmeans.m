%{
kmeans algorithm

input �� 
    X��m x N the input data set��each column is a data
    k��divide data into k clusters

output ��
    center��m x k�� each column is a cluster center
    matrix_0_1��k x N��each colums is a type vector��for example
        column 5 ,(0,0,0,1,0)' means that data 5 belongs to cluster 4
%}
function [center,matrix_0_1] = function_kmeans(X,k)
    m = size(X,1);  %data dimension
    N = size(X,2);  %data size
    %1.randomly selects two data as center points
    center = zerso(m,k);
    rand_index = ceil(rand(1,N) * N);
    for i = 1 : k
        center(:,i) = X(:,rand_index(1,i));
    end
    %2. iterator: find the center point
    center_1 = zerso(m,k);
    matrix_0_1 = zeros(k,N);
    while 1
        distances = zeros(1,k);
        matrix_0_1(:) = 0;
        center = zerso(m,k);
        for i = 1 : N
            for j = 1 : k
               distances(j) = sqrt((X(:,i) - center(:,j)' * (X(:,i) - center(:,j)); % distance between center j and data i
            end
            [v_min,index] = min(distance);
            matrix_0_1(index,i) = 1;    % data i belongs to closest center
        end
        % caculate the new centers
        for i = 1 : k
           for j = 1 : N
               if matrix_0_1(i,j) == 1
                   center(:,i) = center(:,i) + X(:,j);
               end
           end
           center(:,i) = center(:,i) / sum( matrix_0_1(i,:)); % caculate the average center
           
        end
    end
end
