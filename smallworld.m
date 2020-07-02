function G = smallworld(N,p)
tic
e = ones(N,1);
A = spdiags([e e e], -1:1, N, N) - speye(N,N);
A(1,N) = 1; A(N,1) = 1;
m = floor(N*p);
count = 1;

while count <= m 
    ind1 = randi(N);
    ind2 = randi(N);
    if A(ind1,ind2) == 1 || ind1-ind2 == 0
        continue
    end
    A(ind1,ind2) = 1; A(ind2,ind1) = 1;
    count = count + 1;
end
G = graph(A);
toc
end