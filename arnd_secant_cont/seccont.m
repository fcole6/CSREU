%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simple continuation routine
% needs function f with input variables and one parameter
% also needs a derivative Df of f in order to get the tangent
% does not need the derivative specified in f but works much faster with
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%setting up the system and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%system parameters and dimensions
n=3; %number of lattice sites, dimension of system and phase space
d=.01;% coupling strength

%coupling matrix --- define the discrete Laplacian
e=ones(n,1);
D=spdiags([e -2*e e], -1:1, n, n);
D(1,1)=-1;D(n,n)=-1; % corresponds to neumann boundary conditions
D=d*D;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%getting the initial guess
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tentative initial profile and initial parameter value, change this to get other branches
u=zeros(n,1);
%u(1:floor(n/2))=1; %step function
  u(3)=0;u(2)=1/2;u(1)=1;
a=0; %

%forward integration to get a better starting guess if we are looking for a stable solution
%  for j=1:300
%    u=u+0.1*(D*u+u.*(1-u).*(u-a));
%  end

% initial guess formed from solution and parameter value
v=[u;a];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%initializing the continuation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s=0.003;% continuation step size --- should really be adaptive, so that number of Newton iterations needed in each step is kept constant

N=2000; % number of continuation steps 
J=10; % plot every J continuation steps

bifdia=zeros(1,2);%initialize sequence of vectors for bifurcation diagram
xi=[zeros(n,1);1]; % xi is the tangent vector of the coninutation, will be initialized later, now just setting the direction
h=figure(1);
options=optimset('Display','iter','Jacobian','off');



for j=1:N
  v0=v+s*xi;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use Newton as corrector; here with derivative for Newton
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%f0 is function for fsolve, f is externally defined function which needs  parameters
  % need to keep track of the current solution point while going through the Newton iteration in order to enforce orthogonality to secant
  f0=@(v) f(v,D,xi,v0,n);
% this is the Newton step where all the work is done
  v=fsolve(f0,v,options);
  
% recording the main solution measures, appending to vector
    bifdia=[bifdia;v(end) sum((v(1:end-1)))]; %append parameter and L^1 integral
  % tracking the solution
 if mod(j,J)==0
 set(0,'CurrentFigure',h);
      subplot(1,2,1)
    plot(v(1:end-1),'*')
    axis([0 n+1 -0.4 1.4])
    subplot(1,2,2)
    plot(bifdia(2:end,1)',bifdia(2:end,2)','.');
%      plot(bifdia(end,1),bifdia(end,2),'o');
%      axis([-.3 .3 -.5*n 1.5*n])
  drawnow
  end
  xi=v-v0; xi=xi/norm(xi);
end





