omeg = .25;
s = 20;
lam = zeros(s,1)';
ringsize = zeros(s,1)';

for j = 1:s
    n = 10*j;
    ringsize(j)=n;
    e = ones(n,1);
    A = spdiags([e -2*e e], -1:1, n,n);
    A(1,n) = 1;
    A(n,1) = 1;
    A(s/2, s/2) = -2 + omeg;
    lam(j) = eigs(A,1,'largestreal');
end
plot(ringsize,lam);
title('Max e-val vs. ring size (omeg fixed)')
    