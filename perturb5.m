function [N,lam] = perturb5(rel_error,max_iter,m,omeg)

%add m to n every iteration

iter = 1;

n = 51;
N = [n];
%center of graph
n_2 = ceil(n/2);

%make lap the laplacian
%ex=ones(n,1);
%adjx=spdiags([ex, ex],-1:2:1,n,n);
lap=spdiags([ex, -2*ex, ex],-1:1,n,n); lap(1,n) = 1; lap(n,1) = 1;
%lap=kron(speye(n), adjx) + kron(adjx, speye(n));
%for i=1:n
%    lap(i,i) = lap(i,i) + 1;
%    lap(n^2+1-i,n^2+1-i) = lap(n^2+1-i,n^2+1-i) + 1;
%    lap(n*(i-1)+1,n*(i-1)+1) = lap(n*(i-1)+1,n*(i-1)+1) + 1;
%    lap(n*i,n*i) = lap(n*i,n*i) + 1;
%end

figure(1)

adj = lap - diag(diag(lap));
plot(graph(adj))

figure(2)

lap(n_2,n_2) = lap(n_2,n_2) + omeg;

[V,D] = eigs(lap,1,'largestreal');
lam = [D];

while true
    
    iter = iter + 1;
    
    %n is the n from the previous iteration
    U = sparse((n+m)^2,1);
    k = (m/2)*(n+m) +(m/2);
    for i=1:n
        for j = 1:n
            U(k + j) = V((i-1)*n + j);
        end
        k = k + n + m;
    end
    
    %update n here
    n = n+m;
    N = [N, n];
    
    %center of graph
    n_2 = ceil(n^2/2);
    
    ex=ones(n,1);
    lap=spdiags([ex, -2*ex, ex],-1:1,n,n); lap(1,n) = 1;
        lap(n,1) = 1;
    %lap=kron(speye(n), adjx) + kron(adjx, speye(n));
    %for i=1:n
    %lap(i,i) = lap(i,i) + 1;
    %lap(n^2+1-i,n^2+1-i) = lap(n^2+1-i,n^2+1-i) + 1;
    %lap(n*(i-1)+1,n*(i-1)+1) = lap(n*(i-1)+1,n*(i-1)+1) + 1;
    %lap(n*i,n*i) = lap(n*i,n*i) + 1;
    %end
    
    lap(n_2,n_2) = lap(n_2,n_2) + omeg;
    
    try
    [V,D] = eigs(lap,1,lam(end),'StartVector',U);
    catch ME
        fprintf('terminated. error in n = %d ', n);
        fprintf('for omega value %f', omeg);
        break;
    end
    
    lam = [lam, D];
    
    %put while loop condition here so that goes through at least once
    if abs((lam(end) - lam(end-1))/lam(end)) < rel_error
        break
    end
    
    if iter > max_iter
        break
    end
    
end

end