set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

dx=.1;
L=10;
x=(-L:dx:L)';
N=length(x);
e=ones(N,1);

c = hsv(6);

%%%%%%%%%%%%%%%%%%%
% second order Laplacian with Dirichlet
%%%%%%%%%%%%%%%%%%%
lap=spdiags([e -2*e e],-1:1,N,N);
%G = graph(lap);
%lap = -laplacian(G);

%%%%%%%%%%%%%%%%%%%%%
% Neumann
%%%%%%%%%%%%%%%%%%%%%
lap(1,1)=-1;
lap(N,N)=-1;

adj = lap - diag(diag(lap));
G = graph(adj);

n = max(degree(G));

T_end=10000;
dt=.1;

alpha=1;gamma=.1;

A=1+.1*(randn(N,1)+1i*randn(N,1));

g=@(A) A-(1+1i*gamma)*A.*abs(A).^2;
Del=1/dx^2*(1+1i*alpha)*lap; % linear operator as above

% (A_xx)_j~ (A_{j+1}-2 A_j + A_{j-1})/dx^2
% 
%%%%%%%%%%%%%%%%%%%%%
% semi-implicit Euler
%%%%%%%%%%%%%%%%%%%%%
M=speye(N,N)-dt*Del;

%
tplot=1;

% un=u+dt*f(u)

for j=1:T_end/dt
    
    if j == 1000      % perturbation
        omega=zeros(N,1);
        omega(floor(N/2)) = 20;
        %omega(floor(N/2):floor(N/2)+10)=w;
        g=@(u) u+1i*omega.*u-(1+1i*gamma)*u.*abs(u).^2;
    end
    
   An=M\(A+dt*g(A));% semi-implicit, all the work is done here
%     An=A+dt*(Del*A+g(A)); % explicit, need to have dt sufficiently small
%     An=A+dt*(Del*An+g(A));
%     (1-dt*Del)*An=A+dt*g(A)
%     An=(1-dt*Del)\(A+dt*g(A))
%     An=M\(A+dt*g(A))
%     An=A+dt*(Del*An+g(An)); % fully implicit ... ode15s

   A=An;
   if j==4500
    figure(1)
    c_ind = 3;
    plot(x,real(A),'r');
    axis([-L L -1 1]);
    title('CGL with Phase Perturbation $\omega$ = 20, $t = 450$','Interpreter','latex');
    xlabel('Position','Interpreter','latex');
    ylabel('Solution to CGL','Interpreter','latex');
    pbaspect([3 1 1])
    drawnow
   end
   
   if j==4650
    figure(2)
    c_ind = 3;
    plot(x,real(A),'r');
    axis([-L L -1 1]);
    title('CGL with Phase Perturbation $\omega$ = 20, $t = 465$','Interpreter','latex');
    xlabel('Position','Interpreter','latex');
    ylabel('Solution to CGL','Interpreter','latex');
    pbaspect([3 1 1])
    drawnow
   end
   
   if j==4900
    figure(3)
    plot(x,real(A),'r');
    axis([-L L -1 1]);
    title('CGL with Phase Perturbation $\omega$ = 20, $t = 490$','Interpreter','latex');
    xlabel('Position','Interpreter','latex');
    ylabel('Solution to CGL','Interpreter','latex');
    pbaspect([3 1 1])
    drawnow
   end
   
end
