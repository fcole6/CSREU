function A = linear_graph(n)
    e = ones(n,1);
    A = spdiags([e e e],-1:1,n,n) - speye(n);
end