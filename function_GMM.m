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
    alphas = zeros(1,m);
    alphas(:) = 1 / k; 
    [mus,tmp] = function_kmeans(X,k);      % init mu with kmeans cluster center points
    sigmas = zeros(m,k*m);
    diag_1 = zeros(1,m);
    diag_1(:) = 10;
    diag_1 = diag(diag_1);
    sigmas = repmat(diag_1,1,k);      % init sigmas with diag 1
    
    % 2. iteratos till converages
    mini_alphas = zeros(1,m);
    mini_mus = zeros(m,k);
    mini_sigmas = zeros(m,k*m);
    mini_alphas(:) = theta;
    mini_mus(:) = theta;
    mini_sigmas(:) = theta;

    while 1
        % 2.1 E step: calculate the response degree
        r = zeros(k,N);
        for j = 1 : N
           sum_up = 0;
           for  z = 1 : k
               sum_up = sum_up + alphas(z) * mvnpdf(X(:,j)',mus(:,z)',sigmas(:,m*(z-1)+1:m*z));
           end
           
           for i = 1 : k
                r(i,j) = alphas(i) * mvnpdf(X(:,j)',mus(:,i)',sigmas(:,m*(i-1)+1:m*i)) / sum_up;
           end
        end
        
        r
        
        % 2.2 save pre alphas, mus, sigmas
        alphas_pre = alphas;
        mus_pre = mus;
        sigmas_pre = sigmas;
        % 2.3 M step: update alphas, mus, sigmas
        for i = 1 : k
            mus(:,i) = (sum( r(i,:) * X' ) / sum(r(i,:)))';    % update mus
            
            sum_up = zeros(m,m);
            for j = 1 :N
                sum_up = sum_up + r(i,j) * ( X(:,j) - mus(:,k)) * ( X(:,j) - mus(:,k))'; % update 
            end
            sigmas(:,m*(i-1)+1:m*i) =  sum_up / sum(r(i,:));  % update sigmas
            
            alphas(i) = sum(r(i,:)) / N; % update sigmas
        end
        
        % 2.4 if the parameters is convergent£¬exit
        convergent = 1;
        if abs(alphas_pre - alphas) > mini_alphas
            convergent = 0;
        elseif abs( mus_pre - mus) > mini_mus
            convergent = 0;
        elseif abs( sigmas_pre - sigmas) > mini_sigmas
            convergent = 0;
        end
        if convergent == 1
            break;
        end
    end
end