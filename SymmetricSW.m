function A = SymmetricSW(N,c)

e = ones(N,1);
A = spdiags([e 0*e e],-1:1, N,N);
A(1,N) = 1; A(N,1) = 1;

d = ceil(c*(log(N)^2)/2);

for i = 1:d
    ind1 = randi(N);
    ind2 = randi(N);
    if A(ind1,ind2) == 1 || ind1 == ind2
        continue
    end
    A(ind1, ind2) = 1; A(ind2,ind1) = 1;
    A(N-ind1+2,N-ind2+2) = 1; A(N-ind2+2,N-ind1+2)=1;
end
end