%{
guassian probability distribute function

input:
    x:      mx1 column vector
    mu:     mx1 mean value,column vector
    sigma:  mxm coefficient matrix

output:
    pdf_value:  pdf values of the point x
%}
function [ pdf_value ] = function_gauss_pdf(x, mu, sigma)
    if size(x,1) ~= size(mu,1) ||   size(x,1) ~= size(sigma,1) || size(sigma,1) ~= size(sigma,2)
       disp('x, mu, sigma must has the same dimension')
       exit; 
    end
    m = size(x,1);
    det_value = det(sigma);
    if det_value == 0
       disp('the sigma matrix det value cannot be zero')
       exit;
    end
    pdf_value = (2*pi)^(-m/2) * det_value^(-0.5) * exp( -0.5/pi * (x - mu)' * inv(sigma) * (x - mu));
end