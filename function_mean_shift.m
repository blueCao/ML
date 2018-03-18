%{
mean shift cliustering algorithm

input:
    X:  mxN, m dimensions, N datas
    epsilon: the radius distance of the circle
    mini: the minum that close to zero
output:
    y: 1xN, y(i)=c means data i belongs to cluster c 
%}
function [y] = function_mean_shift(X, epsilon, mini)
    m = size(X,1);
    N = size(X,2);
    visited_matrix = zeros(1,N);    % visited_matrix(i)>0 means i-th is visted
    y = zeros(1,N); % y(i) = c means i-th belongs to cluster c
    y(:) = -1;      % init y with -1
   
    cluster_centers = zeros(m,0); % the cluster centers
    centers_tag = zeros(1,0); % the center point cluster tag
    while sum(visited_matrix == 0) > 0
        % 1. random chose an unvisited point
        unvisited_point_index = find(visited_matrix == 0);
        % stop when all point has been visited
        if isempty(unvisited_point_index)
            break;
        end
        cur = X(:,unvisited_point_index(1));% current position
        visited_times = zeros(1, N); % the times that position has been visite
        % 2. move towards the density center until convergent
        while 1
            % 2.1 caculate the density center
            nearby = zeros(1,N+1);%nearby points,the last value shows the nearby nums
            % 2.2 find the nearby point
            for i = 1 :N
                distance = sqrt( (cur - X(:,i)) * (cur - X(:,i))' );
                if distance < epsilon
                    nearby(N+1) = nearby(N+1) +1;
                    nearby(nearby(N+1)) = i;
                    visited_times(i) = visited_times(i) + 1;
                end
            end
            % 2.3 calculate the new center
            if nearby(N+1) < 1
               error('the epsilon is too small, and no point is nearby. please set epsilon with more large num');
            end
            shift = mean(X(:,nearby(1:nearby(N+1))) - repmat(cur,1,nearby(N+1)),2);% the mean shift of the nearby points
            % until the mean shift is small
            if sum(abs(shift)) < m * mini
               break;
            end
            % 2.4 move current position toward the mean shift
            cur = cur + shift ;
        end
        % 3. add cneter point into cluster center
        len = size(cluster_centers,2)+1;% tag is also the new length
        tag = len;
        cluster_centers(:,len) = cur;
        % 4. set the new center point tag
        centers_tag(len) = tag;
        % 5. update the visited point cluster tag
        for i = 1 : N
            if visited_times(i) > visited_matrix(i)
                y(i) = tag;
                visited_matrix(i) = visited_times(i);
            end
        end
        % 6. merge the near center into one
        for i = 1 : len
            distance = sqrt( (cur - cluster_centers(:,i)) * (cur - cluster_centers(:,i))' );
            if  distance < epsilon
                centers_tag(i) = tag;
            end
        end
    end
    
    % update the y tags
    for i = 1 : N
       y(i) = centers_tag(y(i));
    end
    % decrease the tag wholly
    [C,~,y] = unique(y);
    
    % draw if 2D
    if m == 2
       figure
       hold on
       for i = 1:length(C)
           index = find(y==i);
           scatter(X(1,index),X(2,index));
       end
    end
end