%{
DBSCAN algorithm (Density-base spatial clustering of application with noise) 
 
input:
    X:  mxN,    m dimesion , N datas
    epsilon: the minimal distance between the core point and other points
    k:  if point x with k point nearby, the point x is a core point
output:
    y: Nx1. N index which means the i-th data belong to cluseter y(i)

%}
function [ y ] = function_DBSCAN(X, epsilon, k)
    m = size(X,1);
    N = size(X,2);
     % 1. caculate each two point distance(using Euclidean distance)
     % 2. finding the reachable metrix
     distances = zeros(N,N);
     reachable = zeros(N,N);
     
     for i = 1 : N
        for j = i + 1 : N
            distances(i,j) = sqrt(((X(i,:) - X(j,:)' * (X(i,:) - X(j,:)));
            distances(j,j) = distances(i,j);    % symmetrical
            if distance(i,j) < epsilon
                reachable(i,j) = 1;
                reachable(j,i) = 1;
            end
        end
     end
     
     % 3.find all core point
     nearby_nums = zeros(1,N); % nearby_nums(x) is point x's nearby_num
     for p_a_index = 1 : N
         neighbors = 0; % point a's neighbor points num
         for p_b_index = p_a_index + 1 : N
             if reachable(p_a_index,p_b_index) == 1
               nearby_nums(p_a_index) = nearby_nums(p_a_index) + 1;
               nearby_nums(p_b_index) = nearby_nums(p_b_index) + 1;
             end
         end
     end
     core_point_index = zeros(N,N+1);   % last point is the core_point length
     for p = 1 : N
        if nearby_nums >= k
            core_point_index(p, N+1) = core_point_index(p, N+1) + 1;      % length + 1
            core_point_index(p, core_point_index(N+1)) = p;            % add a new core point 
        end
     end
    
     % label the core point with 1,2,3...N
      core_points_labels = 1 : core_point_index(N+1);

     % 3. combime the nearby core points until the core labels don't change
     while 1
        changed = 0;% shows the core pont label changed or not
        for cluster_a = 1 : N
           
           for cluster_b = cluster_a + 1 : N
               
           end
        end
        
     end
     
end





