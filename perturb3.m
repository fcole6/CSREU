function [lam,omeg,loglam,logomeg] = perturb3(A,ind)
G = graph(A);
L = -laplacian(G);

omeg = (0.01: .005: .25)';
M = length(omeg);
lam = zeros(M,1);
k = L(ind,ind);
L(ind,ind) = k + omeg(1);
%lam(1) = eigs(L,1,'largestreal');
lam(1) = eigs(L,1,'largestreal','Tolerance',1e-5,'SubspaceDimension',40);

for j = 2:M
    L(ind,ind) = k + omeg(j);
    %lam(j) = eigs(L,1,'largestreal', 'Tolerance', 1e-7, 'SubspaceDimension',40);
    %lam(j) = eigs(L,1,lam(j-1));
    lam(j) = eigs(L,1,lam(j-1), 'Tolerance', 1e-5, 'SubspaceDimension',40); 
end
loglam = log(lam);
logomeg = log(omeg);
end