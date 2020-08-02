function [lam,omeg,loglam,logomeg] = perturb4(A,ind,omegmax,omegmin,s)

% The main code that we used for plotting eigenvalue vs. perturbation
% inputs: adjacency matrix A, index of perturbed node, max and min
% perturbation values, scaling factor s
% outputs: vector of perturbations omeg, vector of eigenvalues lam, and the
% corresponding log vectors

G = graph(A);
L = -laplacian(G);
N = size(A,1);

omeg = [omegmax]; i=2;

% create perturbation vector

while omeg(i-1) > omegmin
    omeg = [omeg; omeg(i-1)*s]; % use scaling factor to create omeg vector
    i = i+1;
end
m = length(omeg);
lam = zeros(m,1);
e = ones(N,1);

% perturb chosen node
k = L(ind,ind);
L(ind,ind) = k + omeg(1);

tic

% solve for the eigenvalues of the perturbed Laplacian, all the work is done in lines 31-38

% first eigenvalue, for largest perturbation value, using largestreal
[V,D] = eigs(L,1,'largestreal','Tolerance',1e-6,'SubspaceDimension',55, 'isSymmetric', 1);
lam(1) = D;

% use previous eigenvalue/eigenvectors for the next iterations
for j = 2:m
    L(ind,ind) = k + omeg(j);
    [V,D] = eigs(L,1,lam(j-1),'StartVector',V, 'isSymmetric',1);
    lam(j) = D;
end

%take logs of resulting vectors

loglam = log(lam);
logomeg = log(omeg);

toc

end