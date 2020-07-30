function A = reg_tree_w_2_dims(n_tot,n_change,m_1,s_1,m_2,s_2)

%n_total is the total size of the tree
%n_change is the node we wish to change dimensions at
%-----dimension does not actually change until the end of the
%-----level n_change is on is reached
%m_1 and s_1 are the first m,s values as in std. regular tree code
%m_2 and s_2 are the second m,s values " "

%--------------------------
%see regular_tree file for more detailed comments on the tree construction
%--------------------------

    A = sparse(n_tot,n_tot);
    s = s_1; m = m_1;
    
    start = 1;
    target = 2;

    for i=1:s
        A(start,target) = 1;
        target = target + 1;
    end
    
    start = start + 1;
    
    %number of nodes in the current level
    curr_level_size = s;
    %no of total levels of size curr_level_size after last split
    %this is where the powers of m come into play
    power_m = m;
    %no iterations before the next split (updates at every level)
    iter_b4_split = power_m - 1;
    
    while (target < n_tot)
        
        while(target < n_change)
            
        if (iter_b4_split == 0) %split
            
            for i=1:curr_level_size 
                for j=1:s
                    if (target > n_tot) %don't want to go over size limit
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
                if (target > n_tot) %don't want to go over size limit
                    break;
                end
                
                A(start,target) = 1;
                start = start + 1;
                target = target + 1;
                
            end
            
            %update
            iter_b4_split = iter_b4_split - 1;
            
        end
        end
        
        %if target is > n_change, we change dimension
        s = s_2;
        m = m_2;
        %need to change this value in order to go back into while loop
        n_change = n_tot;
        
    end
    A = A + A';
    g = graph(A);
    plot(g);
end