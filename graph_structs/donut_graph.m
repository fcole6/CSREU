function A = donut_graph(n)
    %n must be even
    if mod(n,2) == 1
        n = n - 1;
    end
    m = n/2;
    %first n/2 nodes are in the outer circle
    %second n/2 nodes are in the inner circle
    %make a ring graph of each of these
    %connect node i to node n/2 + 1
    e = ones(m);
    A_1 = spdiags([e e e], -1:1, m,m) - eye(m);
    A_1(1,m) = 1; A_1(m,1) = 1;
    A_2 = spdiags([e], 0, m,m);
    A = [A_1, A_2; A_2, A_1];
end