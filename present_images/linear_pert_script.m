hold on
n = 100000;
c = hsv(10);
for i=1:6
    A = ring_graph(n);
    n_2 = ceil(n/2);
    color = c(i+4, :);
    [lam,omeg,loglam,logomeg] = perturb4(A,n/2);
    plot(logomeg,loglam,'*-','color',color);
    drawnow
    n = n + 100000;
end