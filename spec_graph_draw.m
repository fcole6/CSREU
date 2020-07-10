function spec_graph_draw(A,sn_ID)

B = plot_concentric(A,sn_ID);

G = graph(A);
[N,~] = size(A);
v = (1:N);
D = distances(G,sn_ID,v);
m = max(D);

plot(0,0,'.k','MarkerSize',20)
text(0,0,{' ',num2str(B(1,1))});
hold on
theta = linspace(0, 2*pi, 50).';
R = 1:1:m;
plot(cos(theta)*R, sin(theta)*R,'k');

gamma = sparse(N,2);
gamma(1,:) = [0,0];

for j = 1:m
    x = find(D == j);
    l = length(x);
    for i = 1:l
        index = floor((i)*50/l);
        alpha = cos(theta(index))*R(j);
        beta = sin(theta(index))*R(j);
        temp = B(j+1,i);
        
        plot(alpha,beta,'.k','MarkerSize',20);
        text(alpha,beta,{' ',num2str(temp)});
        gamma(temp,:) = [alpha,beta];
    end
end

end