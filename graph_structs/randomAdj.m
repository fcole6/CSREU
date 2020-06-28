function A = randomAdj(n,beta)
    A = zeros(n,n);
    noEdges = floor(n*(n-1)*beta/2); %divide by two since only working with
    %upper part of the adj matrix
    while(noEdges > 0)
        node = ceil(n*rand(1,2));
        if (node(1,1) == node(1,2))
            continue;
        elseif (node(1,1) > node(1,2)) %only want to set upper part
            temp = node(1,1);
            node(1,1) = node(1,2);
            node(1,2) = temp;
        end
        i = node(1,1); j = node(1,2);
        if (A(i,j) == 0)
            A(i,j) = 1;
            noEdges = noEdges - 1;
        end
    end
    A = A + A';
end