%{
mean shift cliustering algorithm

input:
    X:  mxN, m dimensions, N datas
    epsilon: the radius distance of the circle

output:
    y: 1xN, y(i)=c means data i belongs to cluster c 
%}
function [y] = function_mean_shift(X, epsilon)
    m = size(X,1);
    N = size(X,2);
    visited_matrix = zeros(1,N);    % visited_matrix(i)>0 means i-th is visted
    y = zeros(1,N); % y(i) = c means i-th belongs to cluster c
    y(:) = -1;      % init y with -1
   
    while sum(visited_matrix) < N
        % 1. random chose an unvisited point
        unvisited_point_index = find(visited_matrix == 0);
        % stop when all point has been visited
        if isempty(unvisited_point_index)
            break;
        end
        cur = X(:,unvisited_point_index(0));% current position
        pre_position = cur;% pre position
        
        visited_times = zeros(1, N); % the times that position has been visite
        % 2. move towards the density center until convergent
        while 1
            % 2.1 caculate the density center
            nearby = zeros(1,N+1);%nearby points,the last value shows the nearby nums
            % 2.2 find the nearby point
            for i = 1 :N
                distance = sqrt( (cur - X(:,i)) * (cur - X(:,i)')' );
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
            shift = mean(X(:,nearby(1:nearby(N+1)))')';% the mean shift of the nearby points
            % until the mean shift is small
            if sum(abs(shift)) < m * epsilon
               break;
            end
            % 2.4 move current position toward the mean shift
            cur = cur + shift ;
        end
    end
end