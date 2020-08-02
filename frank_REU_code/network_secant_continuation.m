% Our first attempt at calculating eigenvalue vs. perturbation (for the ring), eventually
% decided using Eigs was faster
% use newton method to converge to a solution on given graph
% attempting to converge to a zero of the function
% A*u + eps*B*u - lam*u = 0
% need additional condition that ||u|| = 1

tic
% create Laplacian matrix
n = 1000;
e = ones(n,1);
A = spdiags([e e], -1:2:1, n, n);
G = graph(A);
A = -laplacian(G);
A(1,n) = 1; A(n,1) = 1;

% perturbation to a single node
B = zeros(n,n);
B(5,5) = 1;

%initialize
eps_init = 1;
s = 0.01;
N = 300; J = 5;
xi = [zeros(n+1,1); -1];


% calculate eigenvalue for smallest perturbation value using Eigs:

options=optimset('Display','off','Jacobian','off');

lam_init = eigs(A + eps_init*B, 1, 'largestreal');
g = @(u_init) A*u_init + eps_init*B*u_init - lam_init*u_init;
u_init = fsolve(g, e, options);

v = zeros(n+2,1); v(1:n,1) = u_init;
v(n+1,1) = lam_init; v(n+2,1) = eps_init;

lam_dia = zeros(1,2);

h=figure(1);

% implement the Jacobian
options=optimset('Display','off','Jacobian','on');

for j=1:N
    
if (v(end) < -1)
    break;
end

% now that we have the first eigenvalue, secant continuation:

v_init=v+s*xi;

f = @(v) epsFunc(v, A, B, xi, v_init, n);
v = fsolve(f, v_init, options);

lam_dia = [lam_dia;v(end) v(end-1)];

%re-initialize secant line, normalize
xi=v-v_init; xi=xi/norm(xi);

end

toc

set(0,'CurrentFigure',h);
plot(lam_dia(2:end,1)',lam_dia(2:end,2)');