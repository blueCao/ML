%{
input :
    sim: NxN ,similarity matrix
    mini_sim: a 0-1 value which makes the Hierarchical  Clustering stops

output:
    cluster_map: NxN, cluster_map(i,j)=k shows tha i-th Hierarchical layer of
                    data j belongs to cluster k
    layer: the layer number

%}
function [ cluster_map, layer ] = fucntion_Hierarchical_Cluster( sim, min_sim)
    if size(sim,1) ~= size(sim,2)
        disp('sim is not a square matrix')
    elseif min_sim>1 || min_sim<0
        disp('mini_sim is not between 0 and 1');
    end
    
    N = size(sim,1);
    
    % 1. init cluster_map with N clusters
    cluster_map = zeros(N,N);
    cluster_map(1,:) = 1:N;
    
    % 2. iterators until less than specific minimun similarity
    iterator = 1;
    while 1
        % 2.1 find two cluster whose similarity is largest
        [C,ia,ic] = unique(cluster_map(iterator,:));
        len = length(C);
        
        if len == 1
            break;
        end
        
        min_1_tag = -1; % init the min two cluseter tag
        min_2_tag = -1;
        current_largest_sim = realmin;
        
        for i = 1 : len
           for j = i + 1 : len
               cluster_i = zeros(1,N);  % cluster i's index
               cluster_j = zeros(1,N);  % cluster j's index
               cluster_i_len = 0;       % cluster i's current length
               cluster_j_len = 0;       % cluster J's current length
               
               i_tag = ic(i);% cluster i's tag
               j_tag = ic(j);% cluster j's tag
               
               % 2.2 find all cluster i datas and cluster j datas
               for k = 1 : N
                   if ic(k) == i_tag
                       cluster_i_len = cluster_i_len + 1;
                       cluster_i(1,cluster_i_len) = k;
                       
                   elseif ic(k) == j_tag
                       cluster_j_len = cluster_j_len + 1;
                       cluster_j(1,cluster_j_len) = k;
                   end
               end
               
               % 2.3 caculate the min similarity between cluster i and j
               min_sim_cluster_i_j = min(min(sim(cluster_i(1:cluster_i_len), cluster_j(1:cluster_j_len))));
               
               % 2.4 update the largest similarity of two cluster i,j
               if current_largest_sim < min_sim_cluster_i_j
                    min_1_tag = cluster_map(iterator,ia(i_tag));
                    min_2_tag = cluster_map(iterator,ia(j_tag));
                    current_largest_sim = min_sim_cluster_i_j;
               end
           end
        end
        
        % 2.5 if little than min_sim, stop
        if current_largest_sim < min_sim
            break;
        end
        
        iterator = iterator + 1;
        
        % 2.6 copy before layer into current and merge two closest clusters into one
        cluster_map(iterator,:) = cluster_map(iterator-1,:);
        cluster_map(iterator,cluster_map(iterator,:)==max([min_1_tag,min_2_tag])) = min([min_1_tag,min_2_tag]);

        % show progress
        iterator
        current_largest_sim
        min_1_tag
        min_2_tag
        cluster_map(iterator,:)
    end
    
    layer = iterator;
end

