%{
simulate the gauss distribute data

input ��
    dim��data dimension
    M��generate M gauss model
    N��generate N datas

output��
    data
    weight
    mu
    sigma
%}
function [data,weight,mu,sigma]=function_Gauss_sample(dim,M,N)
weight=rand(1,M);
weight=weight/norm(weight,1);
sigma=double(randi(3,1,M));  %ÿ����˹�ֲ��ķ����趨��1~10֮��
mu=double(round(randn(dim,M)*10)); %ÿ����˹�ֲ��ľ�ֵ�趨��1~10
n=zeros(1,M);
for i=1:M
    if i~=M
        n(i)=floor(N*weight(i));
    else
        n(i)=N-sum(n);
    end
end
start=0;data=[];
for i=1:M
    X=randn(dim,n(i));
    X=X.*sigma(i)+repmat(mu(:,i),1,n(i));
    data=[X,data];
    start=start+n(i);
end