n = 5;
ex=ones(n,1);
adjx=spdiags([ex, -2*ex, ex],-1:1,n,n);
lap=kron(speye(n), adjx) + kron(adjx, speye(n));
for i=1:n
    lap(i,i) = lap(i,i) + 1;
    lap(n^2+1-i,n^2+1-i) = lap(n^2+1-i,n^2+1-i) + 1;
    lap(n*(i-1)+1,n*(i-1)+1) = lap(n*(i-1)+1,n*(i-1)+1) + 1;
    lap(n*i,n*i) = lap(n*i,n*i) + 1;
end
full(lap)