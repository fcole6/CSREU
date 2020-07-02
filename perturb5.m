function [N,lam] = perturb5(rel_error,max_iter,m,omeg)

%add 5 to n every iteration

iter = 1;

n = 51;
N = [n];
%center of graph
n_2 = ceil(n^2/2);

%make lap the laplacian
ex=ones(n,1);
adjx=spdiags([ex, -2*ex, ex],-1:1,n,n);
lap=kron(speye(n), adjx) + kron(adjx, speye(n));

lap(n_2,n_2) = lap(n_2,n_2) + omeg;
    
[V,D] = eigs(lap,1,'largestreal','StartVector',ones(n^2,1));

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
    
    if (mod(n,50) == 1)
    fprintf('\n n = %d', n);
    fprintf('\n %f', lam(end));
    end
    
    ex=ones(n,1);
    adjx=spdiags([ex, -2*ex, ex],-1:1,n,n);
    lap=kron(speye(n), adjx) + kron(adjx, speye(n));
    
    lap(n_2,n_2) = lap(n_2,n_2) + omeg;
    
    [V,D] = eigs(lap,1,lam(end),'StartVector',U);
    lam = [lam, D];
    
    %put while loop condition here so that goes through at least once
    if abs((lam(end) - lam(end-1))/lam(end)) < rel_error
        break
    end
    
    if mod(iter,30) == 0
        m = m*2;
    end
    
    if iter > max_iter
        break
    end
    
end

end