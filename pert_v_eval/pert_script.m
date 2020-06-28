addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/graph_dim');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/graph_structs');

x = [7000 10000 12000];

fileID = fopen('pert_data.txt','w');

fprintf(fileID, 'Line Graph\n');

for i=1:size(x,2)
    N = x(1,i)
    A = linear_graph(N);
    v = get_data(A);
    fprintf(fileID, '%d %f %e %f %f\n', v);
end

fclose(fileID);
