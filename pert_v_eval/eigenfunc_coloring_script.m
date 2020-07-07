addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_dim');
n = 10;
ex=ones(n,1);
adjx=spdiags([ex, -2*ex, ex],-1:1,n,n);
adjx = adjx - diag(diag(adjx));
A=kron(speye(n), adjx) + kron(adjx, speye(n));
eigenfunc_coloring(A);