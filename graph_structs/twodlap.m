function A = twodlap(n)
%two d lattice
%creates an n^2 graph
n = round(sqrt(n));

ex=ones(n,1);
ey=ones(n,1);

%  %  second order
adjx=spdiags([ex, ex],-1:2:1,n,n);
%graphx = graph(adjx);
%lapx = -laplacian(graphx);
adjy=spdiags([ey, ey],-1:2:1,n,n);
%graphy = graph(adjy);
%lapy = -laplacian(graphy);

% 4th order
%  lapx=spdiags([-1/12*ex 4/3*ex -5/2*ex 4/3*ex -1/12*ex],-2:2,Nx,Nx)/dx^2;
%  lapy=spdiags([-1/12*ey 4/3*ey -5/2*ey 4/3*ey -1/12*ey],-2:2,Ny,Ny)/dy^2;

A=kron(speye(n), adjx) + kron(adjy, speye(n));
%A = A - diag(diag(A));

clear lapx lapy

% test solving Poisson
%  A=A-speye(Nx*Ny,Nx*Ny);
%  f=rand(Nx*Ny,1);

end
%  tic;A\f;toc % appears to use just one core for 4th order laplacian but 2 cores for 4th order Laplacian; memory limitations at Nx*Ny=1.6e7