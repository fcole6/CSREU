% use the secant lines to make steps in a direction
% use newton method to converge to a solution on given graph
% attempting to converge to a zero of the function
% A*u + eps*B*u - lam*u = 0
% need additional condition that ||u|| = 1
function [lam_dia,v] = network_sec_cont(G,ind)

A = -laplacian(G);
n = size(A,1);
%n = 50;
e = ones(n,1);
%A = spdiags([e -2*e e], -1:1, n, n);
%A(1,n) = 1; A(n,1) = 1;
B = zeros(n,n);
B(ind,ind) = 1;

%initialize
eps_init = 1;
s = 0.05;
N = 300; J = 5;
xi = [zeros(n+1,1); -1];

options=optimset('Jacobian','off');

lam_init = eigs(A + eps_init*B, 1, 'largestreal');
g = @(u_init) A*u_init + eps_init*B*u_init - lam_init*u_init;
u_init = fsolve(g, e, options);

options=optimset('Jacobian','on');

v = zeros(n+2,1); v(1:n,1) = u_init;
v(n+1,1) = lam_init; v(n+2,1) = eps_init;

lam_dia = zeros(1,2);

h=figure(1);

tic

for j=1:N
    
if (v(end) < -1)
    break;
end
    
v_init=v+s*xi;

f = @(v) epsFunc(v, A, B, xi, v_init, n);
v = fsolve(f, v_init, options);

lam_dia = [lam_dia;v(end) v(end-1)];
xi=v-v_init; xi=xi/norm(xi);

end


set(0,'CurrentFigure',h);
plot(lam_dia(2:end,1)',lam_dia(2:end,2)');