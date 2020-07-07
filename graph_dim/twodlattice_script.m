addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/pert_v_eval');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_dim');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU');

omeg_vals = [2,1.5,1,.75,.5,.35,.2,.1,.05,.01];
N_vals = sparse(size(omeg_vals,2),60);
lam_vals = sparse(size(omeg_vals,2),60);

for i=1:size(omeg_vals,2)
    tic
    [N,lam] = perturb5(1.0e-3,60,10,omeg_vals(i));
    N_vals(i,1:size(N,2)) = N; lam_vals(i,1:size(lam,2)) = lam;
    toc
end