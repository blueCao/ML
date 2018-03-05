%{
SVM value w
%}
function [w] = function_SVM_w(alpha, x, y)
    n = size(alpha,2);
    if size(y,2) ~= n || size(x,2) ~= n
        disp('y and alpha dimension is not equal!')
        exit
    end
    w = zeros(1,n);
    for i = 1 : n
        w = w + alpha(1,i) * y(1,i) * x(:,i);
    end
end