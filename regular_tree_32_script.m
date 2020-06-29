addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/pert_v_eval');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_dim');

N = 10000;
    A = regular_tree(N,3,2);
    N = size(A,1);
    G = graph(A);
    L = -laplacian(G);
    
    v = get_data(A);
    
    node = 1;
    
    [lam,omeg,loglam,logomeg] = perturb4(A,node);
        
    p = polyfit(logomeg,loglam,1);
    y = polyval(p,logomeg);
    
    p(1)
    
    figure(2)
    plot(logomeg,loglam,'-o',logomeg,y);
    title("Largest Eigenvalue v. Perturbation, Regular Tree (3,2)");
    xlabel("log(omega)");
    ylabel("log(lambda)");