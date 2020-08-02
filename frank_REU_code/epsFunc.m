function f = epsFunc(v, A, B, xi, v_init, n)
    % function called in secant continuation
    % u = eigenvvector to be solved
    % A = Laplacian Matrix
    % B = perturbation matrix = delta_jk
    % v stores the eigenvector, eigenvalue and perturbation
    
    u = v(1:n, 1);
    lam = v(n+1,1);
    eps = v(n+2,1);
    f(1:n) = A*u + eps*B*u - lam*u;
    f(n+1) = norm(u) - 1;
    f(n+2) = (v-v_init)'*xi;
end