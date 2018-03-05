%{
SVM caculate b
%}
function [ b ] = function_SVM_b(alpha, y, x, C, x_y)
    n = size(alpha,2);
    if size(y,2) ~= n || size(x,2) ~= n || size(x_y,1) ~= n || size(x_y,2) ~= n
        disp('alpha, y, x, C, x_y dimension is not equal!')
        exit
    end
    b = zeros(1,1);
    for i = 1 : n
        if 0 < alpha(1,i) && alpha(1,i) < C
            b = y(1,i);
            for j = 1:n
                b = b - alpha(1,i) * alpha(1,j) * x_y(i,j) * y(1,j);
            end
        end
    end
end