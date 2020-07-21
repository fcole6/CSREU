x = [100000, 300000, 500000, 700000];
n = zeros(1,4);
for i=1:size(x,2)
    N = x(1,i);
    [n_i,A] = twodlap(N);   n(1,i) = n_i;
    N_2 = ceil(N/2) + ceil(sqrt(N)/2);
    G = graph(A);   v = dim_array(G,N_2);
    steps = [1:size(v)];
    steps = log(steps); v = log(v);
    figure(i)
    plot(steps,v,'*-k');
end