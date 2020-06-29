addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/pert_v_eval');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
    N = 10000;
    A = twodlap(N);
    N = size(A,1);
    G = graph(A);
    L = -laplacian(G);
    
    node = round((N/2)+floor(sqrt(N)/2));
    
    omeg = (.1: .02: .6)';
    m = length(omeg);
    lam = zeros(m,1);
    
    B = sparse(N,N);
    B(node,node)=1;
    
    C = L + omeg(1)*B;
    lam(1) = eigs(C,1,'largestreal');
    
    for j = 2:m
        C = L + omeg(j)*B;
        try
        lam(j) = eigs(C,1,lam(j-1));
        catch ME
        lam(j) = eigs(C,1,'largestreal');
        end
    end

    log_omeg = log(omeg);
    log_lam = log(lam);
    p = polyfit(log_omeg,log_lam,1);
    y = polyval(p,log_omeg);
    
    p(1)
    
    plot(log_omeg,log_lam,log_omeg,y);
    title("Largest Eigenvalue v. Perturbation, 2-D Lattice");
    xlabel("log(omega)");
    ylabel("log(lambda)");