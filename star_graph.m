function A = star_graph(n)
    A = spdiags(ones(n), 5, n,n);
    A(1,2) = 1; A(1,3) = 1; A(1,4) = 1; A(1,5) = 1;
    A = A + A';
end