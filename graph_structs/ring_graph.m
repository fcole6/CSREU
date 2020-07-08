function A = ring_graph(n)
    e = ones(n,1);
    A = spdiags([e e e],-1:1,n,n) - speye(n);
    A(1,n) = 1; A(n,1) = 1;
end