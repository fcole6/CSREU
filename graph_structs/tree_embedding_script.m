N = [43+8, 259+16, 1555+32, 9331+64, 55981+128, 335923+256];

M = [43];
%add_factor = 8;

%for i=1:5
    %val = N(i+1);
    %M(1,2*i+1) = val;
    %val = val - add_factor;
    %M(1,2*i) = val;
    %add_factor = add_factor * 2;
%end

%size_m = size(M,2);
size_n = size(N,2);

T = sparse(1,size_n);
E = sparse(1,size_n);

for i=1:size_n
    [A,t,e] = tree_embedded_in_ring(N(1,i),3);
    T(1,i) = t;
    E(1,i) = e;
end

hold on;
plot(N,T,N,E);
xlabel('Number of Nodes');
ylabel('Number of Edges');
title('Edges v. Nodes');
legend('Tree','Ring');