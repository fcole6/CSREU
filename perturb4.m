function [lam,omeg,loglam,logomeg] = perturb4(A,ind)
G = graph(A);
L = -laplacian(G);

omeg_curr = 1;
omeg = zeros(50,1); omeg(1) = omeg_curr;
lam = zeros(50,1);

k = L(ind,ind);
L(ind,ind) = k + omeg(1);
%lam(1) = eigs(L,1,'largestreal');
lam(1) = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',50);
omeg_curr = omeg_curr * 2/3;

for j = 2:50
    omeg_curr = omeg_curr * 2/3;
    omeg(j) = omeg_curr;
    L(ind,ind) = k + omeg(j);
    lam(j) = eigs(L,1,lam(j-1));
end

vals = ~isnan(lam);
lam = lam(vals);
omeg = omeg(vals);

loglam = log(lam);
logomeg = log(omeg);
end