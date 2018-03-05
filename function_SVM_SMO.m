%{
SVM implemented by SMO(sequential minization optimization?
%}
function [w,b] = function_SVM_SMO(x1,x2,C,mini)
    x = [x1,x2];
    n = size(x,2);
    y = zeros(1,n);
    y(1,1:size(x1,2)) = 1;
    y(1,size(x1,2)+1:n) = -1;
    alp = zeros(1,n);
    
    % yi * yj * xi' * xj
    x_y = zeros(n,n);
    for i = 1 : n
       for j = 1 : n
           x_y(i,j) = y(1,i) * y(1,j) * x(:,i)' * x(:,j);
       end
    end
    
    %init w,b
    w = function_SVM_w(alpha, x, y);
    b = function_SVM_b(alpha, y, x, C, x_y);
    
    %the distance from satisfied kkt
    delta = zeros(1,n);
    % satisfied kkt
    while 1 = 1
       k = 0;
       type = 0;% type 1: 0<alp<C,type 2: 0=alp,type 3: alp=C,    
        for i = 1 : n
           sum = y(1,i) * (w' * x(:,i) + b;
           if 0 < alp(1,i) && alp(1,i) < C
              
              type = 1;
              k = i;
              break;
           elseif alp(1,i) == 0
               type = 2;
               k = i;
               break;
           elseif alp(1,i) == 0
               
           end
        end
    end
end

