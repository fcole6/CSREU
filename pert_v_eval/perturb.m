function [x,d,s] = perturb(A)
G = graph(A);
L = -laplacian(G);
n = size(L,1);
v1 = centrality(G,'degree');
v2 = centrality(G, 'closeness');
v3 = centrality(G, 'betweenness');
l1 = length(v1); l2 = length(v2); l3 = length(v3);

f1 = sort(v1); f2 = sort(v2); f3 = sort(v3);
v = zeros(9,1); x = zeros(9,4);

degmax = find(v1 == f1(end),1);
v(1) = degmax;
%v = [v; degmax];
degmin = find(v1 == f1(1),1);
v(2) = degmin;
%v = [v; degmin];
degmed = find(v1 == f1(ceil(length(f1)/2)),1);
v(3) = degmed;
%v = [v; degmed];

closemax = find(v2 == f2(end),1);
v(4) = closemax;
%v = [v; closemax];
closemin = find(v2 == f2(1),1);
v(5) = closemin;
%v = [v; closemin];
closemed = find(v2 == f2(ceil(length(f2)/2)),1);
v(6) = closemed;
%v = [v; closemed];

btwmax = find(v3 == f3(end),1);
v(7) = btwmax;
%v = [v; btwmax];
btwmin = find(v3 == f3(1),1);
v(8) = btwmin;
%v = [v; btwmin];
btwmed = find(v3 == f3(ceil(length(f3)/2)),1);
v(9) = btwmed;
%v = [v; btwmed];

omeg = (.1: .02: .6)';
m = length(omeg);
lam = zeros(m,1);

for i = 1:length(v)
    ind = find(v==v(i));
    if ind(1) < i
        x(i,:) = x(ind(1),:);
        continue;
    end
    %figure(i);
    B = zeros(n,n);
    B(v(i),v(i))=1;
    B = sparse(B);
    C = L + omeg(1)*B;
    lam(1) = eigs(C,1,'largestreal');
    for j = 2:m
        C = L + omeg(j)*B;
        try
        lam(j) = eigs(C,1,lam(j-1));
        catch ME
        lam(j) = eigs(C,1,'largestreal');
        end
    end

    log_omeg = log(omeg);
    log_lam = log(lam);
    p = polyfit(log_omeg,log_lam,1);
    y = polyval(p,log_omeg);
    
    %plot(log_omeg,log_lam,log_omeg,y);
    err = abs(log_lam-y);
    error = mean(err);
    x(i,:) = [v(i) p(1) p(2) error];
end
    
    p = p(~isnan(x(2)));
    y = mean(p);
    %y = 2/2-d implies y(2-d) = 2 implies (2/y)-2 = -d
    d = 2 - (2/y);
    s = std(p);
end