function [n,lap] = twodlap(n)
%two d lattice
%creates an n^2 graph
n = round(sqrt(n));
ex=ones(n,1);
adjx=spdiags([ex, ex],-1:2:1,n,n);
lap=spdiags([ex, -2*ex, ex],-1:1,n,n); lap(1,n) = 1; lap(n,1) = 1;
lap=kron(speye(n), adjx) + kron(adjx, speye(n));
%for i=1:n
%    lap(i,i) = lap(i,i) + 1;
%    lap(n^2+1-i,n^2+1-i) = lap(n^2+1-i,n^2+1-i) + 1;
%    lap(n*(i-1)+1,n*(i-1)+1) = lap(n*(i-1)+1,n*(i-1)+1) + 1;
%    lap(n*i,n*i) = lap(n*i,n*i) + 1;
%end
end