%{
Isomap algorithm with epsilon

Input:
    X: m x n matrix,each column is a data
    epsilon: epsilon value
    k: the reduced dimension (k < m < n)
Output:
    Y: transformed value of data X

%}
function [ Y,dist ] = function_Isomap(X, epsilon, k)
    m = size(X,1);
    n = size(X,2);
    % 1.caculate the neighbor graph
    dist = zeros(n,n);
    dist(:,:) = inf;
    for i = 1 : n
       for j = 1 : n
          dist_ij = sqrt( (X(:,i) - X(:,j))' *  (X(:,i) - X(:,j)) );
          if dist_ij < epsilon
             dist(i,j) = dist_ij; 
          end
       end
    end
    dist = min(dist,dist');    % make sure the matrix is symmetric
    
    % 2.construct shortest path
    for i = 1 : n
        dist = min(dist,repmat(dist(:,i),[1 n])+repmat(dist(i,:),[n 1])); 
    end
    
    % 3.remove outliers from graph
    component_index = 1 : n;    % components label
    for i = 1 : n
       for j = i : n
           if dist(i,j) ~= inf
                component_index(1,j) = component_index(1,i);
           end
       end
    end
   component_size = zeros(1,n);
   for i = 1 : n
        component_size(1,component_index(1,i)) = component_size(1,component_index(1,i)) + 1;
   end
   [largest_size,largest_index] = max(component_size);
   dist_index = find(component_index == largest_index);     % keep the largest components index
   dist = dist(dist_index,dist_index);      % keep the largest component only
   
   % 4.MDS
   dist = dist.*dist;
   m = mean(mean(dist));
       % calculate b(i,j)
    b = zeros(length(dist),length(dist));
    for i = 1 : length(dist)
        for j = 1 : length(dist)
            b(i,j) = -0.5 * (dist(i,j) + m - mean(dist(i,:)) - mean(dist(j,:)));
        end
    end
    % eigent values and vectors
    [egi_vectors,egi_values]=eig(b);
    egi_values = real(egi_values);
    [value_sort,sort_index]=sort(diag(egi_values),'descend');
    egi_vectors = egi_vectors(:,sort_index);
    egi_vectors = egi_vectors(:,1:k);
    egi_values = diag(egi_values);
    egi_values = egi_values(sort_index,:);
    egi_values = egi_values(1:k,:);
    
    Y =egi_vectors * sqrt(diag(egi_values));
    Y = Y';
end
