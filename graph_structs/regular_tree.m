function A = regular_tree(n,m,split)
    %n number of nodes, split is desired dimension
    A = sparse(n,n);
    a = split; %num of nodes in curr row
    b = m - 1; % a - (num of times that row size has been added)
    c = m;
    
    last_node = 1; %used to make sure no out of bounds errors
    first_node = 1;
    
    while(b > 1)
        A(first_node,first_node + 1) = 1;
        first_node = first_node+1;
        last_node = last_node + 1;
        b = b - 1;
    end
    for i=1:split
        A(first_node,last_node + 1) = 1;
        last_node = last_node + 1;
    end
    first_node = first_node + 1;
    c = c*m;
    b = c;
    
    while (last_node < n)
        if (b == 1) %split
            start_node = first_node; %start w first node of curr row
            end_node = first_node + a; %start w first node of next row
            for i=1:a
                for j=1:split
                    if (end_node > n)
                        break;
                    end
                    A(start_node,end_node) = 1; %connect indices end_node
                    end_node = end_node + 1; %...thru end_node + split - 1
                end
                start_node = start_node + 1; %start again w next start node
            end
            first_node = first_node + a; %update variables
            a = a*split;
            last_node = end_node - 1;
            c = c*m;
            b = c;
        else %dont split
            start_node = first_node;
            end_node = start_node + a;
            for i=1:a
                if (end_node > n)
                    break;
                end
                A(start_node,end_node) = 1;
                start_node = start_node + 1;
                end_node = end_node + 1;
            end
            b = b - 1;
            last_node = end_node - 1;
            first_node = first_node + a;
        end
    end
    A = A + A';
    g = graph(A);
    plot(g);
end