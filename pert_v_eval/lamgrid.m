tic

N = 1000;
e = ones(N,1);
f = zeros(N,1);
A = spdiags([e f e], -1:1, N,N);
A(1,N) = 1;
A(N,1) = 1;
G = graph(A);
L = -laplacian(G);

omeg = (0: .01: .5)';
M = length(omeg);
lam = zeros(M,1);
L(10,10) = -2 + omeg(1);
lam(1) = eigs(L,1,'largestreal');

for j = 2:M
    L(10,10) = -2 + omeg(j);
    try
    lam(j) = eigs(L,1,lam(j-1));
    catch ME
    lam(j) = eigs(L,1,'largestreal');
    end
end

omeg = log(omeg);
lam = log(lam);

p = polyfit(omeg,lam,1);
g = zeros(M,1);
f = @(x) p(1)*x+p(2);
for i = 1:M
    g(i)=f(omeg(i));
end

toc

plot(omeg,lam,omeg,g);
title('Max e-val vs. potential');
hold off