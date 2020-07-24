function eigenfunc_coloring(A)
    figure(2);
    G = graph(A);
    A = -laplacian(G);
    
    n_2 = size(A,1)/2 + floor(sqrt(size(A,1))/2);
    %k = A(n_2,n_2);
    
    %omega_vals = [0.25,0.5,1,2,4];
    
    for j=1:20
    figure(j)
    %omega = omega_vals(j);
    A(n_2,n_2) = A(n_2,n_2) + 0.25;
    [eig,~] = eigs(A,1,'largestreal');
    eig = abs(eig);
    h = plot(G);
    c = hsv(100);
    e_max = max(eig);
    e_min = min(eig);
    range = e_max - e_min;
    if range < 0.0001
        range = 1; %if range<0.1 possible calc error
    end
    eig_colors = ceil((eig - e_min)*90/range);
    for i=1:size(A,1)
    if eig_colors(i) == 0
        eig_colors(i) = 1;
    end
        c_i = c(eig_colors(i),:);
        highlight(h,i,'NodeColor',c_i);
    end
    
    pause(0.5);
    
    end
end