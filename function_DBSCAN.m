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
            distances(i,j) = sqrt( ( X(:,i) - X(:,j) )'  *  ( X(:,i) - X(:,j) ) );
            distances(j,i) = distances(i,j);    % symmetrical
            if distances(i,j) < epsilon
                reachable(i,j) = 1;
                reachable(j,i) = 1;
            end
        end
     end
     % 3.find all core point
     nearby_nums = zeros(1,N); % nearby_nums(x) is point x's nearby_num
     for p_a_index = 1 : N
         for p_b_index = p_a_index + 1 : N
             if reachable(p_a_index,p_b_index) == 1
               nearby_nums(p_a_index) = nearby_nums(p_a_index) + 1;
               nearby_nums(p_b_index) = nearby_nums(p_b_index) + 1;
             end
         end
     end
     core_point_index = zeros(1,N+1);   % last point is the core_point length
     is_core_points_index = zeros(1,N); % if is_core_points_index(x) == p && p~=0,point x is core point and its lablel index is p
     for p = 1 : N
        if nearby_nums(p) >= k
            core_point_index(N+1) = core_point_index(N+1) + 1;      % length + 1
            core_point_index(core_point_index(N+1)) = p;            % add a new core point 
            is_core_points_index(p) = core_point_index(N+1);        % set the label index
        end
     end
     % 4. label the core point with 1,2,3...N
      core_points_labels = 1 : core_point_index(N+1);
      core_point_length = core_point_index(N+1);
      
     % 5. combime the nearby core points until the core labels don't change
     while 1
        changed = 0;% shows the core pont label changed or not
        for cluster_a = 1 : core_point_length
           core_a_index = core_point_index(cluster_a);
           
           for cluster_b = cluster_a + 1 : core_point_length
                core_b_index = core_point_index(cluster_b);
                
                % combine the nearby core points into the same one
                if reachable(core_a_index,core_b_index) == 1 && core_points_labels(cluster_a) ~= core_points_labels(cluster_b);
                    core_points_labels(cluster_b) = min(core_points_labels(cluster_a),core_points_labels(cluster_b) );
                    core_points_labels(cluster_a) = min(core_points_labels(cluster_a),core_points_labels(cluster_b) );
                    changed  = 1;
                end
           end
        end
        
        if changed == 0;
            break;
        end
     end
     
     % 6. relabel the core point labels
     [~,~,ic] = unique(core_points_labels);
     core_points_labels = ic;
     
     % 7. label all points
     y = zeros(1,N);
     for point_index = 1 : N
         % 7.1 the current point is the core point
         if is_core_points_index(point_index) ~= 0
            y(point_index) = core_points_labels(is_core_points_index(point_index));
            continue;
         end
         
         % 7.2 the current point is not core point,get nearby core point
         for c_index = 1 : core_point_length
             if reachable(point_index, core_point_index(c_index)) == 1
                 y(point_index) = core_points_labels(c_index);
             end
         end
     end
   
     % draw 2D picture if X is two dimension
     if m == 2
        figure;
        hold on;
        [C,~,ic] = unique(y);
        for i = 1 : length(C)
            y_i = find(ic==i);
            scatter(X(1,y_i),X(2,y_i));
        end
         % draw the noise points
         y_i = find(y==0);
        scatter(X(1,y_i),X(2,y_i),'square');
        
         % draw the core points
        scatter(X(1,core_point_index(1:core_point_index(N+1))),X(2,core_point_index(1:core_point_index(N+1))),'.');
     end
end
