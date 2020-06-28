function spec_graph_draw(adj,lap)
    [V,~] = eigs(lap,3,'largestreal');
    R = V(:,[2 3]);
    gplot(adj, R);
end