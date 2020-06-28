function [f J] = epsFunc(v, A, B, xi, v_init, n)
    u = v(1:n, 1);
    lam = v(n+1,1);
    eps = v(n+2,1);
    f(1:n) = A*u + eps*B*u - lam*u;
    f(n+1) = u'*u - 1;
    f(n+2) = (v-v_init)'*xi;
    J = [A+eps*B-lam*speye(n,n) -1*u B*u; 2*u'  0  0;  xi'];
end