function plotcircles(A,ind)

G = graph(A);
[N,~] = size(A);
v = (1:N);
D = distances(G,ind,v);
m = max(D);

plot(0,0,'.k','MarkerSize',16)
hold on
theta = linspace(0, 2*pi, 50).';
R = 1:1:m;
plot(cos(theta)*R, sin(theta)*R,'k');

for j = 1:m
    x = find(D == j);
    l = length(x);
    for i = 1:l
        index = floor((i)*50/l);
        plot(cos(theta(index))*R(j),...
            sin(theta(index))*R(j),'.k','MarkerSize',16);
    end
end
end