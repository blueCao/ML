%{
gaussian mixture model with EM algorithm

input:
    X:mxN input datas, each columns is a data. m is data dimension,
        N datas
    k£ºthe numbers of gaussian model
    theta: the min change value of two iterators stop
output:
    alphas£º1xk £¬ k weights of gaussian mixuture model
    mus£ºmxk , k gaussian mean values
    sigmas:mx(mxk) , each m x k is a covariance
%}
function [alphas, mus, sigmas] = function_GMM(X, k, theta)
    m = size(X,1); % m dimensions
    N = size(X,2); % N datas
    % 1. init alphas (weights)¡¢alphas¡¢mus, sigmas
    alphas = zeros(1,k);
    alphas(:) = 1 / k; 
    [mus,tmp] = function_kmeans(X,k)      % init mu with kmeans cluster center points
    sigmas = zeros(m,k*m);
    diag_1 = zeros(1,m);
    diag_1 = rand(1,m) * 10;
    diag_1 = diag(diag_1);
    sigmas = repmat(diag_1,1,k);      % init sigmas with rand value from 0 to 10
    
    % 2. iteratos till converages
    mini_alphas = zeros(1,k);
    mini_mus = zeros(m,k);
    mini_sigmas = zeros(m,k*m);
    mini_alphas(:) = theta;
    mini_mus(:) = theta;
    mini_sigmas(:) = theta;

    iterator = 1;
    while 1
        % 2.1 E step: calculate the response degree
        r = zeros(k,N);
        
        alpha_pdf = zeros(k,N); % the temp value of alpha * pdf
        for i = 1 : k
           for j = 1 : N
              alpha_pdf(i,j) = alphas(i) *  function_gauss_pdf(X(:,j),mus(:,i),sigmas(:,m*(i-1)+1:m*i));
           end
        end

        sum_up_alpha_pdf = zeros(1,N); % the temp value of the sum alpha * pdf
        for i = 1 : N
            sum_up_alpha_pdf(i) = sum(alpha_pdf(:,i));
        end
        
        for i = 1:N
           for j = 1 : k
              r(j,i) = alpha_pdf(j,i) / sum_up_alpha_pdf(i);    % the response degree of model j to point i
           end
        end
        
        % 2.2 save pre alphas, mus, sigmas
        alphas_pre = alphas;
        mus_pre = mus;
        sigmas_pre = sigmas;
        % 2.3 M step: update alphas, mus, sigmas
        sum_up_r = zeros(1,k); % tmp value of sum up r
        for i = 1 :k
            sum_up_r(i) = sum(r(i,:));
        end
        for i = 1 : k
            mus(:,i) = (sum( r(i,:) * X' ) / sum_up_r(i))';    % update mus
            
            sum_up = zeros(m,m);    % tmp value of sum up r * (x - mu) * (x - mu)'
            for j = 1 :N
                sum_up = sum_up + r(i,j) * ( X(:,j) - mus(:,k)) * ( X(:,j) - mus(:,k))'; % update 
            end
            sigmas(:,m*(i-1)+1:m*i) =  sum_up / sum_up_r(i);  % update sigmas
            
            alphas(i) = sum_up_r(i) / N; % update sigmas
        end
        
        % 2.4 if the parameters is convergent£¬exit
        if sum(abs(alphas_pre - alphas) < mini_alphas) == k && sum(sum(abs( mus_pre - mus) < mini_mus)) == m*k && sum(sum(abs( sigmas_pre - sigmas) < mini_sigmas)) == m* k * m 
            break;
        end
        iterator = iterator + 1;
    end
    iterator
end