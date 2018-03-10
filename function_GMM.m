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
function [alpahs, mus, sigmas] = function_GMM(X, k, theta)
    m = size(X,1); % m dimensions
    N = size(X,2); % N datas
    % 1. init alphas (weights)¡¢alpahs¡¢mus, sigmas
    alphas = zeros(1,m);
    alphas(:) = 1 / k;
    mus = rand(m,k);
    sigmas = rand(m,k);

    
    % 2. iteratos till converages
    r = zeros(1,N);
    while 1
        % 2.1 E step: calculate the response degree
        r = zeros(k,N);
        for i = 1 : k
           for j = 1 : N
                sum = 0;
                for  z = 1 : k
                   sum = alphas(z) * normpdf(X(:,j),mus(:,z),sigmas(:,sigmas(:,m*(z-1):m*z)));
                end
                r(i,j) = alphas(i) * normpdf(X(:,j),mus(:,i),sigmas(:,sigmas(:,m*(i-1):m*i))) / sum;
           end
        end
        % 2.2 save pre alpahs, mus, sigmas
        alphas_pre = alpahs;
        mus_pre = mus;
        sigmas_pre = sigmas;
        % 2.3 M step: update alpahs, mus, sigmas
        for i = 1 : k
            mus(:,i) = sum( r(i,:) * X );
            
        end
    end
end