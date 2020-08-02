function spec_graph_draw(A,sn_ID)

% simulates the CGL equation on a network using colors, with the perturbed node in
% the center of the plot, and other nodes lying on concentric circles
% according their distance from the perturbed node

%%plot before coloring
G = graph(A);
[N,~] = size(A);
v = (1:N);
D = distances(G,sn_ID,v);
m = max(D);

%%rows of B correspond to distance
%%values in B correspond to node ID
B = plot_concentric(A,sn_ID,m);

plot(0,0,'.k','MarkerSize',20)
text(0,0,{' ',num2str(B(1,1))});
hold on

% plot the concentric circles
theta = linspace(0, 2*pi, 50).';
R = 1:1:m;
plot(cos(theta)*R, sin(theta)*R,'k');

%gamma stores coordinates with row corresponding to node ID
gamma = sparse(N,2);
gamma(sn_ID,:) = [0,0];

% plot the nodes on the circles
for j = 1:m
    x = find(D == j);
    l = length(x);
    for i = 1:l
        index = floor((i)*50/l);
        phi = cos(theta(index))*R(j);
        psi = sin(theta(index))*R(j);
        temp = B(j+1,i);
        
        plot(phi,psi,'.k','MarkerSize',20);
        text(phi,psi,{' ',num2str(temp)});
        gamma(temp,:) = [phi,psi];
    end
end
drawnow;
%pause(0.5);

%now to actually plot colors

L = -laplacian(G);
L(1,1) = -1; L(N,N) = -1;

% initialize timestep, length of time interval
dt = 0.1; tf = 1000;

%initial condition, parameters
u = 1-.1*(randn(N,1)+i*randn(N,1));
c = hsv(300); %colorbar
alpha=2.5; beta=1.3;

color_indices = ceil(abs(u)*50 + 50); %range of values for colorbar
colors = zeros(N,3);

for j=1:N
    colors(j,:) = c(color_indices(j),:);
end

scatter(gamma(:,1),gamma(:,2),20,colors,'filled');
drawnow;
%pause(0.5);

omega=zeros(N,1);
omega(floor(N/2)-5:floor(N/2)+5) = -0.3;

g=@(u) u+i*omega.*u-(1+i*beta)*u.*abs(u).^2; % functions/operators for CGL, as in graph_ode
Del = (1+i*alpha)*L;
M = speye(N,N) - dt*Del;

for j = 1:(tf/dt)    
    
    g_1 = g(u);
    un = M\(u+dt*g_1);     % semi-implicit Euler
    u = un;
    cols = abs(u); % assign colors using node absolute values
    color_indices = ceil(cols*50 + 50);
    colors = zeros(N,3);

    for k=1:N
        colors(k,:) = c(color_indices(k),:);
    end
    scatter(gamma(:,1),gamma(:,2),20,colors,'filled');
    drawnow;
end


end