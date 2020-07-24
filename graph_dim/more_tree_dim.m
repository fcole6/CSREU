N = 336179;

A = tree_embedded_in_ring(N,3);
G = graph(A);

tree_ring_dim = dim_array(G,1);

N_vals = 1:size(dim_array,1);
log_N = log(N_vals);
log_dim = log(tree_ring_dim);

plot(log_N, log_dim, 'LineWidth',5);
xlabel('$\log(t)$','Interpreter','latex')
ylabel('$log(N(t))$','Interpreter','latex')
title('Dimension Plot for Tree Embedded in Ring, $m = 3$, $s=2$','Interpreter','latex')
