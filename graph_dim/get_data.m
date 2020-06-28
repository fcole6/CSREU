function v = get_data(A)
tic
    %input adjacency matrix A
    n = size(A,1);
    %output with data we wish to record
    v = zeros(1,5);
    %dimension
    v(1,1) = n;
    starting_node = round((n/2)+floor(sqrt(n)/2));
    %starting_node=1;
    arry = dim_array(graph(A),starting_node)
    j = 0;
    for i=1:size(arry)-2
        if 2*arry(i+1)-arry(i) > arry(i+2)
            j = i;
            break;
        end
    end
    if j ~= 0
    arry = arry(1:j,1)
    end
    arry = log(arry);
    x = [1:size(arry)];
    x = x(floor(size(arry,1)/2):size(arry,1));
    arry = arry(floor(size(arry,1)/2):size(arry,1));
    x = x';
    x = log(x);
    f = polyfit(x,arry,1);
    %slope
    slope = f(1); v(1,2) = slope;
    polyfit_vals = polyval(f,x);
    plot(x,arry,'o-',x,polyfit_vals);
    %error
    toc
    error = abs(polyfit_vals - arry);
    avg_e = mean(error); v(1,3) = avg_e;
    %call perturbation function here, return [M,avg_p]
    %[x,d,s] = perturb(A); v(1,4) = d; v(1,5) = s;
end

