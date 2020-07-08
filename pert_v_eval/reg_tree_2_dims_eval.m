addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');
addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_dim');

A = reg_tree_w_2_dims(80,7,1,2,2,3);

%n_change for m_1=2,s_1=2:
%101, 373, 1429, 5589, 22101, 87893, 350549

function A = reg_tree_w_2_dims(n_tot,n_change,m_1,s_1,m_2,s_2)
    A = sparse(n_tot,n_tot);
    s = s_1; m = m_1;
    a = s; %num of nodes in curr row
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
    for i=1:s
        A(first_node,last_node + 1) = 1;
        last_node = last_node + 1;
    end
    first_node = first_node + 1;
    c = c*m;
    b = c;
    
    while (last_node < n_tot)
        while(last_node < n_change)
        if (b == 1) %split
            start_node = first_node; %start w first node of curr row
            end_node = first_node + a; %start w first node of next row
            for i=1:a
                for j=1:s
                    if (end_node > n_change)
                        break;
                    end
                    A(start_node,end_node) = 1; %connect indices end_node
                    end_node = end_node + 1; %...thru end_node + split - 1
                end
                start_node = start_node + 1; %start again w next start node
            end
            first_node = first_node + a; %update variables
            a = a*s;
            last_node = end_node - 1;
            c = c*m;
            b = c;
        else %dont split
            start_node = first_node;
            end_node = start_node + a;
            for i=1:a
                if (end_node > n_change)
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
        s = s_2;
        m = m_2;
        n_change = n_tot;
    end
    A = A + A';
    g = graph(A);
    plot(g);
end