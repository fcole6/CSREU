addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/pert_v_eval');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_dim');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU');

omeg_vals_2 = [.8,.6,.4,.2,.1,.05];
N_vals_2 = sparse(size(omeg_vals_2,2),70);
lam_vals_2 = sparse(size(omeg_vals_2,2),70);

for i=1:size(omeg_vals,2)
    try
    [N,lam] = perturb5(1.0e-3,70,10,omeg_vals_2(i));
    N_vals_2(i,1:size(N,2)) = N; lam_vals_2(i,1:size(lam,2)) = lam;
    catch ME
        fprintf('error in i = %d', i);
    end
end