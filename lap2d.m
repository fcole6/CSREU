dx=.025/8;
dy=.025/16;
Lx=1*pi;
Ly=1*pi;
x=(-Lx:dx:Lx)';
Nx=length(x);
y=(-Ly:dy:Ly)';
Ny=length(y);
n=Nx*Ny;

ex=ones(Nx,1);
ey=ones(Ny,1);

%  %  second order
lapx=spdiags([ex -2*ex ex],-1:1,Nx,Nx)/dx^2;
lapy=spdiags([ey -2*ey ey],-1:1,Ny,Ny)/dx^2;

% 4th order
%  lapx=spdiags([-1/12*ex 4/3*ex -5/2*ex 4/3*ex -1/12*ex],-2:2,Nx,Nx)/dx^2;
%  lapy=spdiags([-1/12*ey 4/3*ey -5/2*ey 4/3*ey -1/12*ey],-2:2,Ny,Ny)/dy^2;

A=kron(speye(Ny), lapx) + kron(lapy, speye(Nx));
clear lapx lapy

% test solving Poisson
%  A=A-speye(Nx*Ny,Nx*Ny);
%  f=rand(Nx*Ny,1);
%  tic;A\f;toc % appears to use just one core for 4th order laplacian but 2 cores for 4th order Laplacian; memory limitations at Nx*Ny=1.6e7