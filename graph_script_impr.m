%types of graphs: line, 2dlat, extd. star, small-world, regular
%dim: 10, 100, 300, 500, 1000, 3000, 5000

%mkdir('C:/Users/Franck/iCloudDrive/reu_2020/code');
%addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/pert_v_eval');
%addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/graph_structs');

x = [100, 300, 500, 1000, 3000, 5000];

fileID = fopen('graph_data.txt','w');

fprintf(fileID, 'Line Graph\n'); disp('line');

for i=1:size(x,2)
    N = x(1,i);
    A = linear_graph(N);
    [v,z] = get_data(A);
    fprintf(fileID, '%d %f %e %f %e\n', v);
    fprintf(fileID, '\tPerturbation Data\n');
    for i=1:size(z,1)
        fprintf(fileID, '\t%d %f %f %e\n', z(i,:));
    end
        fprintf(fileID, '\n');
end

fprintf(fileID, '\n2-D Lattice\n'); disp('lattice');

for i=1:size(x,2)
    N = x(1,i);
    A = twodlap(N);
    [v,z] = get_data(A);
    fprintf(fileID, '%d %f %e %f %e\n', v);
    fprintf(fileID, '\tPerturbation Data\n');
    for i=1:size(z,1)
        fprintf(fileID, '\t%d %f %f %e\n', z(i,:));
    end
        fprintf(fileID, '\n');
end

fprintf(fileID, '\nExtd. 5-Pt Star\n'); disp('5 pt');

for i=1:size(x,2)
    N = x(1,i);
    A = star_graph(N);
    [v,z] = get_data(A);
    fprintf(fileID, '%d %f %e %f %e\n', v);
    fprintf(fileID, '\tPerturbation Data\n');
    for i=1:size(z,1)
        fprintf(fileID, '\t%d %f %f %e\n', z(i,:));
    end
        fprintf(fileID, '\n');
end

beta = [0.001,0.005,0.01];
kappa = [2,3];
for j=1:size(beta,2)
    for k=1:size(kappa,2)
    fprintf(fileID, '\nSmall World: Beta = ');
    disp(['sw - ', num2str(beta(j)), ' , ', num2str(kappa(k))]);
    fprintf(fileID, '%.3f', beta(j));
    fprintf(fileID, ', K = ');
    fprintf(fileID, '%d', kappa(k));
    fprintf(fileID, '\n');
    for i=1:size(x,2)
    N = x(1,i);
    A = WattsStrogatz(N, kappa(k), beta(j));
    [v,z] = get_data(A);
    fprintf(fileID, '%d %f %e %f %e\n', v);
    fprintf(fileID, '\tPerturbation Data\n');
    for i=1:size(z,1)
        fprintf(fileID, '\t%d %f %f %e\n', z(i,:));
    end
        fprintf(fileID, '\n');
    end
    end
end

kappa = [3,4,5];
for j=1:size(kappa,2)
    fprintf(fileID, '\nRegular Graph: Degree = ');
    disp(['reg - ', num2str(kappa(j))]);
    fprintf(fileID, '%d', kappa(j));
    fprintf(fileID, '\n');
    for i=1:size(x,2)
    N = x(1,i);
    A = createRandRegGraph(N, kappa(j));
    [v,z] = get_data(A);
    fprintf(fileID, '%d %f %e %f %e\n', v);
    fprintf(fileID, '\tPerturbation Data\n');
    for i=1:size(z,1)
        fprintf(fileID, '\t%d %f %f %e\n', z(i,:));
    end
        fprintf(fileID, '\n');
    end
end

fclose(fileID);