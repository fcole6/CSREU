function eval_v_potential(incr, maxN, maxOmeg)

noColors = floor(maxN/incr);
c = jet(noColors);

omeg = (-1*maxOmeg: .01: maxOmeg)';
M = length(omeg);
lam = zeros(M,1)';
figure(1);
hold on;

tic

for N=10:incr:maxN
e = ones(N,1);
f = zeros(N,1);
A = spdiags([e f e], -1:1, N,N);
A(1,N) = 1;
A(N,1) = 1;
G = graph(A);
L = -laplacian(G);

for j = 1:M
    L(10,10) = -2 + omeg(j);
    lam(j) = eigs(L,1,'largestreal');
end
plot(omeg,lam);
end

toc

colororder(c);
cb = colorbar;
nvals = [incr,maxN+incr];
caxis(nvals);
xlabel('Perturbation Value');
ylabel('E-Val with Largest Re Part');
ylabel(cb, 'Number of Nodes');
title('Max e-val vs. potential in ring structure');