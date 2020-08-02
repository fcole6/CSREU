function A = smallworld(N,p)

% Generates the adjacency matrix for a small-world network on N vertices
% with rewiring probability p (initial graph is a 4-regular ring lattice)

tic
e = ones(N,1);
A = spdiags([e e e e e], -2:2, N, N) - speye(N,N);
A(1,N-1) = 1; A(1,N) = 1; A(2,N) = 1;
A(N-1,1) = 1; A(N,1) = 1; A(N,2) = 1;

m = floor(N*p); % number of rewirings
count = 1;

while count <= m 
    ind1 = randi(N); % indices of rewiring
    ind2 = randi(N);
    if A(ind1,ind2) == 1 || ind1-ind2 == 0
        continue
    end
    A(ind1,ind2) = 1; A(ind2,ind1) = 1;
    k = randi(2);
    A(ind1, ind1+k) = 0; A(ind1+k,ind1) = 0; % finish rewiring (delete close edge)
    count = count + 1;
end
toc
end