function graph_ode(A,dt,tf,w)

% Simulation for CGL equation on networks: imput adjacency matrix, timestep/final time, and perturbation value

[N,~] = size(A);

% create graph laplacian w/ boundary conditions

G = graph(A);
lap = -laplacian(G);
lap(1,1) = -1; lap(N,N) = -1;

% initial conditions/parameters

u = rand(N,1);
alpha=2.5;gamma=1.3;

G.Nodes.NodeColors = real(u);    % assign colors based on abs(u) or real(u) (must change manually)
NodeCData = G.Nodes.NodeColors;
plot(G,'NodeCData',G.Nodes.NodeColors);
caxis([-1.4 1.4]);
colorbar
drawnow

g=@(u) (1)*u-(1+i*gamma)*u.*abs(u).^2; % define operators/functions appearing in CGL equation
Del = (1+i*alpha)*lap;
M = speye(N,N) - dt*Del;

for j = 1:(tf/dt)    
    if j == 50      % perturbation to phase
        omega=zeros(N,1);
        omega(N-4:N) = w; omega(1:4) = w;
        omega(floor(N/2)-5:floor(N/2)+5) = w;
        g=@(u) u+i*omega.*u-(1+i*gamma)*u.*abs(u).^2;
    end
    
    un = M\(u+dt*g(u));     % solve CGL using semi-implicit Euler method
    u = un;
    G.Nodes.NodeColors = real(u);
    NodeCData = G.Nodes.NodeColors;
    
    if mod(j,5) == 0
    plot(G,'NodeCData',G.Nodes.NodeColors); % change the colors based on solution vector
    caxis([-1.4 1.4]);
    colorbar
    drawnow
    end
end
end