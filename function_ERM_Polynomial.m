%{
Empirical Risk Minimization using Polynomial function

input:
    x:x values
    y:y values
    m:using w0 + w1x^1 + w2x^2 +...+ wmx^m

output:
    w: factors
    loss: loss with w

%}
function [w,loss] = function_ERM_Polynomial(x,y,m)
    X = zeros(size(x,1),0);
    for i = 0:m
        x_i = x.^i;
        X=[X,x_i];
    end
    w = X \ y
    y_estimate = X * w;
    loss = sum( (y_estimate - y) .^ 2 )
    
    % draw graph
    figure;
    plot(x,y)
    min_x = x(1,1);
    max_x = x(size(x,1),1);
    x = min_x : 0.01 : max_x;
    x = x';
    X_esitmate = zeros(size(x,1),0);
    for i = 0:m
        x_i = x.^i;
        X_esitmate = [X_esitmate,x_i];
    end
    y_estimate = X_esitmate * w;
    hold on
    scatter(x, y_estimate)
end