function get_data(A)
tic
    %input adjacency matrix A
    n = size(A,1);
    %output with data we wish to record
    v = zeros(1,5);
    %dimension
    v(1,1) = n;
    %define starting node for dim_array:
    starting_node=1;
    arry = dim_array(graph(A),starting_node);
    arry = log(arry);
    x = [1:size(arry)]; x = x'; x = log(x); %makes "steps" to put on x-axis
    f = polyfit(x,arry,1);
    polyfit_vals = polyval(f,x);
    figure(1)
    plot(x,arry,'o-',x,polyfit_vals);
    title("Dimension of regular tree");
    xlabel("log(n)");
    ylabel("log(V)");
    toc
    v(1,2) = f(1);  v(1,3) = f(2);
    v(1,4) = mean(abs(polyfit_vals - arry));
end