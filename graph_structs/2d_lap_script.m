[~,A] = twodlap(10);
G = graph(A);
figure(1)
plot(G);
lap = -laplacian(G);
lap(1,1)=-1;
lap(100,100)=-1;
figure(2)
spec_graph_draw(A,lap);
figure(3)
y = dim_array(G,50);
loglog(1:size(y,1),y);