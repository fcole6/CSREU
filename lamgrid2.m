% Computes the first eigenvalue for various different ring sizes
% (all multiples of 10), perturbation omega is fixed

omeg = .75;
s = 30;
lam = zeros(s,1)';
ringsize = zeros(s,1)';

for j = 1:s
    n = 10*j;
    ringsize(j)=n;
    e = ones(n,1);
    A = spdiags([e -2*e e], -1:1, n,n);
    A(1,n) = 1;
    A(n,1) = 1;
    A(10, 10) = -2 + omeg;
    lam(j) = eigs(A,1,'largestreal');
end
plot(ringsize,lam);
title('Max e-val vs. ring size (omeg fixed)')  