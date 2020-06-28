function G = dim2tree(n)
A = sparse(2^(2*n),2^(2*n));
topnode = 2;
leftnode = 1;

for i = 1:n
    for j = 1:2^(i-1)
        for k = 1:2
        A(topnode,leftnode) = 1;
        A(leftnode,topnode) = 1;
        topnode = topnode +1;
        end
        leftnode = leftnode+1;
    end
    for l = 1:(2^i -1)*(2^i)
        A(topnode,leftnode) = 1;
        A(leftnode,topnode) = 1;
        topnode = topnode +1;
        leftnode = leftnode +1;
    end

end
G = graph(A);
end