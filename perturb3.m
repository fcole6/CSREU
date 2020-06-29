function [lam,omeg,loglam,logomeg] = perturb3(A,ind)
G = graph(A);
L = -laplacian(G);

omeg = (0.01: .01: .4)';
M = length(omeg);
lam = zeros(M,1);
k = L(ind,ind);
L(ind,ind) = k + omeg(1);
%lam(1) = eigs(L,1,'largestreal');
lam(1) = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',50);

for j = 2:M
    L(ind,ind) = k + omeg(j);
    lam(j) = eigs(L,1,'largestreal', 'Tolerance', 1e-6, 'SubspaceDimension',50);
    %lam(j) = eigs(L,1,lam(j-1));
    %lam(j) = eigs(L,1,lam(j-1), 'Tolerance', 1e-6, 'SubspaceDimension',50); 
end

if isnan(lam(1)) == 1
    lam = lam(2:end);
    omeg = omeg(2:end);
end

for j = 2:M-1
    if isnan(lam(j)) == 1
        lam(j) = lam(j-1) + omeg(j-1)^2;
    end
end

loglam = log(lam);
logomeg = log(omeg);
end