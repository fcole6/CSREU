function [x,d,s] = perturb(A)

% input adjacency matrix, output is the slope, y-intercept, and error of
% the line of best fit of the eigenvalue vs. perturbation plot for several
% different perturbed nodes

% our first attempt at plotting eigenvalue vs. perturbation, our plan was
% to consider the effects of perturbing nodes of different centrality and
% comparing the effects

G = graph(A);
L = -laplacian(G);
n = size(L,1);

% calculate centrality of nodes (using the three different centrality
% metrics)

v1 = centrality(G,'degree'); 
v2 = centrality(G, 'closeness');
v3 = centrality(G, 'betweenness');

l1 = length(v1); l2 = length(v2); l3 = length(v3);
f1 = sort(v1); f2 = sort(v2); f3 = sort(v3);
v = zeros(9,1); x = zeros(9,4);

% find vertices of max, min, and median degree centrality
degmax = find(v1 == f1(end),1);
v(1) = degmax;

degmin = find(v1 == f1(1),1);
v(2) = degmin;

degmed = find(v1 == f1(ceil(length(f1)/2)),1);
v(3) = degmed;

% find vertices of max, min, and median closeness centrality
closemax = find(v2 == f2(end),1);
v(4) = closemax;

closemin = find(v2 == f2(1),1);
v(5) = closemin;

closemed = find(v2 == f2(ceil(length(f2)/2)),1);
v(6) = closemed;

% find vertices of max, min, and median betweenness centrality

btwmax = find(v3 == f3(end),1);
v(7) = btwmax;
btwmin = find(v3 == f3(1),1);
v(8) = btwmin;
btwmed = find(v3 == f3(ceil(length(f3)/2)),1);
v(9) = btwmed;

omeg = (0: .01: .5)'; % perturbation vector
m = length(omeg);
lam = zeros(m,1);


% for each vertex, calculate the eigenvalue scaling under perturbation
for i = 1:length(v)
    ind = find(v==v(i));
    if ind(1) < i
        x(i,:) = x(ind(1),:);
        continue;
    end

    B = zeros(n,n);
    B(v(i),v(i))=1;
    B = sparse(B);
    C = L + omeg(1)*B;
    lam(1) = eigs(C,1, 'largestreal');%, 'Tolerance', 1e-5);
    for j = 2:m
        
        % our original attempt at computing eigenvalues involved using
        % largest real, could adapt code to use previous
        % eigenvalue/eigenvector
        
        C = L + omeg(j)*B;
        try
        lam(j) = eigs(C,1,lam(j-1));%, 'Tolerance', 1e-5);
        catch ME
        %lam(j) = lam(j-1);
        lam(j) = eigs(C,1,'largestreal');%, 'Tolerance', 1e-5);
        end
    end
    
    % calculate slopes, y-intercepts, and error in fit-line through log-log
    % plot
    
    log_omeg = log(omeg);
    log_lam = log(lam);
    p = polyfit(log_omeg,log_lam,1);
    y = polyval(p,log_omeg);
    err = abs(log_lam-y);
    error = mean(err);
    x(i,:) = [v(i) p(1) p(2) error];
end
    p = p(~isnan(x(2)));
    y = mean(p);
    
    
    % calculate dimension: y = 2/2-d implies y(2-d) = 2 implies (2/y)-2 = -d
    d = 2 - (2/y);
    s = std(p);
end