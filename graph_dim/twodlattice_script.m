addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/pert_v_eval');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU');
    N = 10000;
    A = twodlap(N);
    N = size(A,1);
    G = graph(A);
    L = -laplacian(G);
    
    v = get_data(A);
    
    node = round((N/2)+floor(sqrt(N)/2))
    
    [lam,omeg,log_lam,log_omeg] = perturb4(A,node);

    p = polyfit(log_omeg,log_lam,1);
    y = polyval(p,log_omeg);
    
    p(1)
    
    figure(2)
    plot(log_omeg,log_lam,log_omeg,y);
    title("Largest Eigenvalue v. Perturbation, 2-D Lattice");
    xlabel("log(omega)");
    ylabel("log(lambda)");