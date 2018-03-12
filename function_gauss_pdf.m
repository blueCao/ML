%{
guassian probability distribute function

input:
    x:      mxn each colum is a column vector,has n value
    mu:     mx1 mean value,column vector
    sigma:  mxm coefficient matrix

output:
    pdf_value:  pdf values of the point x
%}
function [ pdf_value ] = function_gauss_pdf(x, mu, sigma)
    if size(x,1) ~= size(mu,1) ||   size(x,1) ~= size(sigma,1) || size(sigma,1) ~= size(sigma,2)
       disp('x, mu, sigma must has the same dimension')
    end
    m = size(x,1);
    n = size(x,2);
    det_value = det(sigma);
    if det_value == 0
       disp('the sigma matrix det value cannot be zero')
    end
    pdf_value = zeros(n,1);
    for i = 1 : n
        pdf_value(i) = (2*pi)^(-m/2) * det_value^(-0.5) * exp( -0.5/pi * (x(:,i) - mu)' * inv(sigma) * (x(:,i) - mu));
    end
end