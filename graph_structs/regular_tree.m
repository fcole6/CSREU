function A = regular_tree(n,m,s)

    %n number of nodes
    %m is the base for powers we split on
    %s is the number of nodes we split into at each split
    %-----ex. for a std. binary tree, m = 1, s = 2
    
    A = sparse(n,n);
    
    %start is a node on the current level and
    %target is a node on the next level
    %that we wish to connect to the start node
    start = 1;
    target = 2;
    
    %connect starting node to all nodes in the next level
    for i=1:s
        A(start,target) = 1;
        target = target + 1;
    end
    
    %set start to first node in second level
    start = start + 1;
    %target is already updated to the first node in third level
    
    %number of nodes in the current level
    curr_level_size = s;
    %no of total levels of size curr_level_size after last split
    %this is where the powers of m come into play
    power_m = m;
    %no iterations before the next split (updates at every level)
    iter_b4_split = power_m - 1;
    
    while (target < n) %don't want to go over size limit
        
        if (iter_b4_split == 0) %split
            
            %this code connects each node in the current level
            %-----this corresponds to curr_level_size
            %to its children in the next level
            %-----each parent node connects to s children
            for i=1:curr_level_size 
                for j=1:s
                    if (target > n) %don't want to go over size limit
                        break;
                    end
                    A(start,target) = 1;
                    target = target + 1;
                end
                start = start + 1;
            end
            
            %update variables
            curr_level_size = curr_level_size*s;
            power_m = power_m*m;
            iter_b4_split = power_m-1;
            
        else %if not splitting
            
            for i=1:curr_level_size 
                if (target > n) %don't want to go over size limit
                    break;
                end
                
                %connect start node to only 1 node in next level
                A(start,target) = 1;
                start = start + 1;
                target = target + 1;
                
            end
            
            %update
            iter_b4_split = iter_b4_split - 1;
            
        end
        
    end
    
    %current matrix is an upper triangular, and we wish to obtain
    %the full symmetric matrix:
    A = A + A';
    g = graph(A);
    plot(g);
    
end