%{
mean shift image segmentaion algorithm

input:
    image_path: image file path string
    output_path: the segmentation image file output path string
    epsilon: the radius distance of the circle
    mini: the minum that close to zero
output:
   null
%}
function  function_mean_shift_image_segmentation(image_path, output_path, epsilon, mini)
    rgb = im2double(imread(image_path));% rgb(w,h,3) image matrix
    height = size(rgb,1);
    width = sieze(rgb,2);
    visited_matrix = zeros(height,width);    % visited_matrix(i,j)>0 means <i,j> is visted
    y = zeros(height,width,2);% y(i,j) = c means i-th belongs to point c
    y(:,:,:) = 0;      % init y with 0
    cluster_centers = zeros(2,0); % the cluster centers
    centers_color = zeros(3,0); % the center point cluster color
    while sum(visited_matrix(:) == 0) > 0
        % 1. random chose an unvisited point
        unvisited_point_index = find(visited_matrix);
        unvisited_h = (unvisited_point_index - 1) / width + 1;
        unvisited_w = mod(unvisited_point_index - 1,width) + 1;
        cur_r = rgb(unvisited_h,unvisited_w,1);% current position
        cur_g = rgb(unvisited_h,unvisited_w,2);
        cur_b = rbg(unvisited_h,unvisited_w,3);
        cur_h = unvisited_h;
        cur_w = unvisited_w;
        
        visited_times = zeros(height,width); % the times that position has been visite
         % 2. move towards the density center until convergent
        while 1
            % 2.1 caculate the density center
            nearby = zeros(2,0);%nearby points
            nearby_nums = 0;
            distances = zeros(1,0);
            % 2.2 find the nearby point
            for h = 1 : height
                for w = 1 : width
                    distance = sqrt( (cur_r - rgb(h,w,1))^2 + (cur_g - rgb(h,w,2))^2 +(cur_b - rgb(h,w,3))^2);
                    if distance < epsilon
                        nearby_nums = nearby_nums +1;
                        nearby(2,nearby_nums) = [h,w];
                        visited_times(h,w) = visited_times(h,w)  + 1;
                        distances(nearby_nums) = distance;
                    end
                end
            end
            % 2.3 calculate the new center
            if nearby_nums < 1
               error('the epsilon is too small, and no point is nearby. please set epsilon with more large num');
            end
            % the mean shift of the nearby points
            shift_height = 0;
            shift_width = 0;
            for i = 1 : nearby_nums
                shift_height = shift_height + distances(i) *  unvisited_h;
                shift_width = shift_width + distances(i) *  unvisited_w;
            end
            shift_height = shift_height / sum(distances);
            shift_width = shift_width / sum(distances);
            % until the mean shift is small
            if sum(abs(shift_height)) + sum(abs(shift_width)) < 2 * mini
               break;
            end
            % 2.4 move current position toward the mean shift
            cur_h = cur_h + shift_height ;
            cur_w = cur_w + shift_width;
        end
    end
end