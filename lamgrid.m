N = 500;
e = ones(N,1);
f = zeros(N,1);
A = spdiags([e f e], -1:1, N,N);
A(1,N) = 1;
A(N,1) = 1;
G = graph(A);
L = -laplacian(G);

omeg = (.01: .01: .5)';
M = length(omeg);
lam = zeros(M,1);
L(10,10) = -2 + omeg(1);
%lam(1) = eigs(L,1,'largestreal');
lam(1) = eigs(L,1,'smallestabs');

for j = 2:M
    L(10,10) = -2 + omeg(j);
    lam(j) = eigs(L,1,lam(j-1));       
end

p = polyfit(log(omeg),log(lam),1);
g = zeros(M,1);
f = @(x) p(1)*x+p(2);
for i = 1:M
    g(i)=f(log(omeg(i)));
end
plot(log(omeg),log(lam));
hold on
plot (log(omeg),g);
title('Max e-val vs. potential');
hold off