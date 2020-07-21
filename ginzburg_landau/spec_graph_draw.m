function spec_graph_draw(A,sn_ID)

%%plot before coloring
G = graph(A);
[N,~] = size(A);
v = (1:N);
%%get the distances from the node sn_ID
%%inorder to plot
D = distances(G,sn_ID,v);
m = max(D);

%%rows of B correspond to distance
%%values in B correspond to node ID
B = plot_concentric(A,sn_ID,m);

plot(0,0,'.k','MarkerSize',20)
text(0,0,{' ',num2str(B(1,1))});
hold on
theta = linspace(0, 2*pi, 50).';
R = 1:1:m;
plot(cos(theta)*R, sin(theta)*R,'k');

%gamma stores coordinates with row corresponding to node ID
gamma = sparse(N,2);
gamma(sn_ID,:) = [0,0];

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
pause(0.5);

%now to actually plot colors

L = -laplacian(G);
L(1,1) = -1; L(N,N) = -1;

dt = 0.1;    tf = 1000;

u = 1-.1*(randn(N,1)+1i*randn(N,1));
c = hsv(100);
alpha=2.5; beta=1.3;

color_indices = ceil(real(u)*30+50);
colors = zeros(N,3);

for j=1:N
    colors(j,:) = c(color_indices(j),:);
end

scatter(gamma(:,1),gamma(:,2),20,colors,'filled');
drawnow;
pause(0.5);

g=@(u) u-(1+1i*beta)*u.*abs(u).^2;
Del = (1+1i*alpha)*L;
M = speye(N,N) - dt*Del;

for j = 1:(tf/dt)
    
    if j == 50      % perturbation
        omega=zeros(N,1);
        omega(sn_ID) = -3;
        %omega(floor(N/2):floor(N/2)+10)=w;
        g=@(u) u+1i*omega.*u-(1+1i*beta)*u.*abs(u).^2;
    end
    
    un = M\(u+(dt*g(u)));     % semi-implicit Euler
    u = un;
    color_indices = ceil(real(u)*30+50);
    colors = zeros(N,3);

    for k=1:N
        colors(k,:) = c(color_indices(k),:);
    end
    
    scatter(gamma(:,1),gamma(:,2),20,colors,'filled');
    drawnow;
end

end