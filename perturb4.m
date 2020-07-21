function [lam,omeg,loglam,logomeg] = perturb4(A,ind)
G = graph(A);
L = -laplacian(G);
N = size(A,1);

omeg = [20]; i=2;

while omeg(i-1) > .0000001
    omeg = [omeg; omeg(i-1)*.5];
    i = i+1;
end
m = length(omeg);
lam = zeros(m,1);
e = ones(N,1);


k = L(ind,ind);
L(ind,ind) = k + omeg(1);

tic

[V,D] = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',50);
%[V,D] = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',50);
lam(1) = D;

for j = 2:m
    L(ind,ind) = k + omeg(j);
    [V,D] = eigs(L,1,lam(j-1),'StartVector',V);
    lam(j) = D;
end

loglam = log(lam);
logomeg = log(omeg);

toc
end