function [lam,omeg,loglam,logomeg] = perturb4(A,ind)
G = graph(A);
L = -laplacian(G);

omeg(1,1) = 3/4;
i = 2;
while(omeg(1,i-1) > 1/4)
    omeg(1,i) = omeg(1,i-1)*.9;
    i = i + 1;
end
lam = zeros(1,size(omeg,2));

k = L(ind,ind);
L(ind,ind) = k + omeg(1,1);
%lam(1) = eigs(L,1,'largestreal');
lam(1,1) = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',50);

for j = 2:size(omeg,2)
    L(ind,ind) = k + omeg(1,j);
    lam(1,j) = eigs(L,1,lam(1,j-1));
end

loglam = log(lam)
logomeg = log(omeg)
end