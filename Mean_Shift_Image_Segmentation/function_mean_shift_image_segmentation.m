%{
mean shift image segmentaion algorithm

input:
    image_path: image file path string
    box: the box pixel;
    output_path: the segmentation image file output path string
    mini: the minum that close to zero
output:
   ouput_matrix: the output color matrix
%}
function [ouput_matrix] = function_mean_shift_image_segmentation(image_path, box, output_path, mini )
    rgb = im2double(imread(image_path));% rgb(w,h,3) image matrix
    height = size(rgb,1);
    width = size(rgb,2);
    visited_matrix = zeros(height,width);    % visited_matrix(i,j)>0 means <i,j> is visted
    y = zeros(height,width);% y(i,j) = c means i-th belongs to point c
    y(:) = 0;      % init y with 0
    cluster_centers = zeros(2,width * height); % the cluster centers position
    centers_color = zeros(3,width * height); % the center point cluster color
    centers_tag = zeros(1,width * height); % the center point cluster tag
    len = 0; % the cluster center nums
    while sum(visited_matrix(:) == 0) > 0
        % 1. random chose an unvisited point
        unvisited_h = 0;
        unvisited_w = 0;
        unvisited_size = length(find(visited_matrix(:)==0))
        for h = 1 : height
            for w = 1 : width
                if visited_matrix(h,w) < 1
                    unvisited_h = h;
                    unvisited_w = w;
                    break;
                end
            end
        end
        if unvisited_h == 0
            break;
        end
        cur_r = rgb(unvisited_h,unvisited_w,1);% current position
        cur_g = rgb(unvisited_h,unvisited_w,2);
        cur_b = rgb(unvisited_h,unvisited_w,3);
        cur_h = unvisited_h;
        cur_w = unvisited_w;
        
        visited_times = zeros(height,width); % the times that position has been visite
         % 2. move towards the density center until convergent
        while 1
            % 2.1 caculate the density center
            nearby = zeros(2,height*width);%nearby points
            nearby_nums = 0;
            distances = zeros(1,height*width);
            % 2.2 find the nearby point
            top_h = max([cur_h - box,1]);
            buttom_h = min([cur_h + box,height]);
            left_w = max([cur_w - box,1]);
            right_w = min([cur_w + box,width]);
            
            for h = top_h : buttom_h
                for w = left_w : right_w
                    distance = sqrt( (cur_r - rgb(h,w,1))^2 + (cur_g - rgb(h,w,2))^2 +(cur_b - rgb(h,w,3))^2);
                    nearby_nums = nearby_nums +1;
                    nearby(:,nearby_nums) = [h;w];
                    visited_times(h,w) = visited_times(h,w)  + 1;                    
                    distances(nearby_nums) = distance;
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
                shift_height = shift_height + distances(i) *  (unvisited_h - cur_h);
                shift_width = shift_width + distances(i) *  (unvisited_w - cur_w);
            end
            shift_height = shift_height / sum(distances);
            shift_width = shift_width / sum(distances);
            % until the mean shift is small
            if sum(abs(shift_height)) + sum(abs(shift_width)) < 2 * mini
               break;
            end
            % 2.4 move current position toward the mean shift
            cur_h = cur_h + shift_height;
            cur_w = cur_w + shift_width;
        end
        % 3. add cneter point into cluster center
        len = len + 1;% tag is also the new length
        tag = len;
        centers_color(:,len) = [cur_r;cur_g;cur_b];
        cluster_centers(:,len) = [cur_h;cur_w];
        % 4. set the new center point tag
        centers_tag(len) = tag;
        % 5. update the visited point cluster tag
        for h = 1 : height
            for w = 1 : width
                if visited_times(h,w) > visited_matrix(h,w)
                    y(h,w) = tag;
                    visited_matrix(h,w) = visited_times(h,w);
                end
            end
        end
        % 6. merge the near center into one and smooth the color
        near_num = 0;
        smooth_color = zeros(3,1);
        for i = 1 : len
            color_distance = sqrt( (cur_r - centers_color(1,i))^2 + (cur_g - centers_color(2,i))^2 +(cur_b - centers_color(3,i))^2);
            location_distance = sqrt( (cur_h - cluster_centers(1,i))^2 + (cur_w - cluster_centers(2,i)^2));
            if  location_distance < box && color_distance < 0.01
                centers_tag(i) = tag;
                smooth_color(1) = centers_color(1,i);
                smooth_color(2) = centers_color(2,i);
                smooth_color(3) = centers_color(3,i);
                near_num = near_num +1;
            end
        end
        smooth_color = smooth_color / near_num;
        centers_color(1,tag) = smooth_color(1);
        centers_color(2,tag) = smooth_color(2);
        centers_color(3,tag) = smooth_color(3);
    end
    % keep the color num legal [0,1]
    for i = 1 : len
       centers_color(1,i) = max([min([centers_color(1,i),1]),0]);
       centers_color(2,i) = max([min([centers_color(2,i),1]),0]);
       centers_color(3,i) = max([min([centers_color(3,i),1]),0]);
    end
    % output the segmentation image
    ouput_matrix = zeros(height,width,3);
    for h = 1 : height
        for w = 1 : width
            ouput_matrix(h,w,1) = centers_color(1,y(h,w));
            ouput_matrix(h,w,2) = centers_color(2,y(h,w));
            ouput_matrix(h,w,3) = centers_color(3,y(h,w));
        end
    end
    imwrite(ouput_matrix,output_path,'jpg','Comment','lenna image segmentationresult');
end