function [A,tree_edges,extra_ring_edges] = tree_embedded_in_ring(n,m)
    A = sparse(n,n);
    b = m;  c = m;
    
    extra_ring_edges = 0;
    tree_edges = 0;

    A(1,2) = 1; A(1,n) = 1;
    tree_edges = tree_edges + 2;
    curr_row = [2];
    size_of_subtree = floor(n/2);
    
    while (curr_row(end) < ceil(n/2))
        if (b == 1) %split
            size_of_subtree = ceil(size_of_subtree/2);
            new_row = [];
            %connect nodes in row to the 2 approp nodes
            for i=1:size(curr_row,2)
                A(curr_row(1,i),curr_row(1,i)+1) = 1;
                A(curr_row(1,i),curr_row(1,i)+size_of_subtree) = 1;
            new_row = [new_row, curr_row(1,i)+1,curr_row(1,i)+size_of_subtree];
                dist_to_n = curr_row(1,i) - 2;
                A(n - dist_to_n, n - dist_to_n - 1) = 1;
                A(n - dist_to_n, n - dist_to_n -...
                    size_of_subtree) = 1;
                tree_edges = tree_edges + 4;
            end
            %rewrite the curr set as these two nodes
            curr_row = new_row;
            c = c*m;
            b = c;
        else %dont split
            %connect nodes in row to the next row
            new_row = [];
            for i=1:size(curr_row,2)
                A(curr_row(i),curr_row(i)+1) = 1;
                new_row = [new_row, curr_row(i)+1];
                dist_to_n = curr_row(i) - 2;
                A(n - dist_to_n, n - dist_to_n - 1) = 1;
                tree_edges = tree_edges + 2;
            end
            %update currrow variable
            curr_row = new_row;
            size_of_subtree = size_of_subtree -1;
            b = b - 1;
        end
    end
    A = A + A';
    for i=1:n-1
        if A(i,i+1) ~= 1
            A(i,i+1) = 1;
            extra_ring_edges = extra_ring_edges + 1;
            A(i+1,i) = 1;
        end
    end
    
end