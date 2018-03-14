%{
export the result file according the cluster_map result

input:
    cluster_map:    1xN vector
    raw:    Nxm
    result_file_path:   the output file path

    input raw cells format:each line
    ���,��  ��,��ʳ����,����,ˮ��,������,֬��,��ʳ��ά,̼ˮ����,ά����A,ά����B1,ά����B2,����,ά����E,��,��,��,���,ά����C,���̴�


output:
    result_fille:  the output csv file

    output csv file format:each line
    ���,���,��  ��,��ʳ����,����,ˮ��,������,֬��,��ʳ��ά,̼ˮ����,ά����A,ά����B1,ά����B2,����,ά����E,��,��,��,���,ά����C,���̴�
    
%}
function [ result_fille ] = function_export_result(cluster_map, raw, result_file_path)
    % 1. get each cluster line index according cluster_map
    [C,ia,ic] = unique(cluster_map);
    cluster_size = length(C);
    data_size = length(cluster_map);
    cluster_line_index = zeros(cluster_size, data_size+1);% cluster_line_index[i,data_size+1] last location stores cluster i data size
    for i = 1 : data_size
        cluster_tag = ic(i);
        % 1.1 cluster add the new data
        current_length = cluster_line_index(cluster_tag, data_size+1);
        cluster_line_index(cluster_tag, current_length + 1) = i;

        % 1.1 cluster length + 1
        cluster_line_index(cluster_tag, data_size+1) = current_length + 1;
    end
    
    % 2 output file
    result_fille = fopen(result_file_path,'w');
    head_formatSpec = '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n';
    data_formatSpec = '%d,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n';

    % 2.1 append head
    fprintf(result_fille, head_formatSpec, '���', raw{1,:});
    
    % 2.2 append data
    for cluster_id = 1 : size(cluster_line_index,1)
        data_length = cluster_line_index(cluster_id, data_size + 1); % data length
        for data_index = 1 : data_length
            row_index = cluster_line_index(cluster_id, data_index);
            fprintf(result_fille, data_formatSpec, cluster_id, raw{row_index + 1,:}); % including the head line: row_index + 1
        end
    end
    
    % 2.3 close the output file
    fclose(result_fille);
end

