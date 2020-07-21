function graph_ode(A,dt,tf,w)
% imput adjacency matrix, timestep/final time, and perturbation value

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

g=@(u) (1)*u-(1+i*gamma)*u.*abs(u).^2;
Del = (1+i*alpha)*lap;
M = speye(N,N) - dt*Del;

for j = 1:(tf/dt)    
    if j == 50      % perturbation
        omega=zeros(N,1);
        omega(floor(N/2)) = w;
        %omega(floor(N/2):floor(N/2)+10)=w;
        g=@(u) u+i*omega.*u-(1+i*gamma)*u.*abs(u).^2;
    end
    
    un = M\(u+dt*g(u));     % semi-implicit Euler
    u = un
    G.Nodes.NodeColors = real(u);
    NodeCData = G.Nodes.NodeColors;
    
    if mod(j,5) == 0
    plot(G,'NodeCData',G.Nodes.NodeColors);
    caxis([-1.4 1.4]);
    colorbar
    drawnow
    end
end
end