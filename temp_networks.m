close all
dx=1;
L=1000;
x=(-L:dx:L)';
N=length(x);
e=ones(N,1);

%%%%%%%%%%%%%%%%%%%
% second order Laplacian with Dirichlet
%%%%%%%%%%%%%%%%%%%
lap=spdiags([e -2*e e],-1:1,N,N);
%A = WattsStrogatz(N,2,.01);
%lap = -laplacian(G);

%%%%%%%%%%%%%%%%%%%%%
% Neumann
%%%%%%%%%%%%%%%%%%%%%
lap(1,1)=-1;
lap(N,N)=-1;
%n = max(degree(G));

T_end=10000;
dt=.1;

alpha=2.5;gamma=1.3;

A=ones(N,1);%+.1*(randn(N,1)+i*randn(N,1));

g=@(A) (1)*A-(1+i*gamma)*A.*abs(A).^2;
Del=1/dx^2*(1+i*alpha)*lap; % linear operator as above

% (A_xx)_j~ (A_{j+1}-2 A_j + A_{j-1})/dx^2
% 
%%%%%%%%%%%%%%%%%%%%%
% semi-implicit Euler
%%%%%%%%%%%%%%%%%%%%%
M=speye(N,N)-dt*Del;

%
tplot=10;

% un=u+dt*f(u)

for j=1:T_end/dt
    
    if j == 100
        omega=zeros(N,1);
        omega(floor(N/2):floor(N/2)+10)=-.3;
        g=@(A) A+i*omega.*A-(1+i*gamma)*A.*abs(A).^2;
    end
    
    
    
   An=M\(A+dt*g(A));% semi-implicit, all the work is done here
%     An=A+dt*(Del*A+g(A)); % explicit, need to have dt sufficiently small
%     An=A+dt*(Del*An+g(A));
%     (1-dt*Del)*An=A+dt*g(A)
%     An=(1-dt*Del)\(A+dt*g(A))
%     An=M\(A+dt*g(A))
%     An=A+dt*(Del*An+g(An)); % fully implicit ... ode15s

   A=An;
   if mod(j,floor(tplot/dt))==0
    plot(x,abs(A))
    
   % plot(x,real(A))
    axis([-L L -1.5 1.5])
    title(['time=' num2str(j*dt)])
    drawnow
   end
   
end
