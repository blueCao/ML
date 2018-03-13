%{
load data from the local csv file

input:
    file_path

output:
    names:  1xm  has m dimensions,each dimension is a nutrient content
    X:      Nxm  has N data(foods)
%}

% 1. load_data_from_excel
data=csvread('中国普通食物营养成分表一览.csv',1,2);
N = size(data,1);
m = size(data,2);
X=data;

% 2. change value into [0,1]
for dim = 1 : m
    X(:,dim) = mapminmax(X(:,dim)',0,1)';
end

% 3. caculate the similarity(p,q)
 [ sim ] = function_similarity_matrix( X' );

% 4. perform Hierarchical  Clustering
