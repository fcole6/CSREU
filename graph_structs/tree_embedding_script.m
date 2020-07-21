N = [43+8, 259+16, 1555+32, 9331+64, 55987+128, 335923+256];

size_n = size(N,2);

avg_short_path = zeros(1,size_n);

%S = zeros(1,size_n);
%T = zeros(1,size_n);
%R = zeros(1,size_n);

for i=1:size_n
    [A,~,~,~] = tree_embedded_in_ring(N(1,i),3);
    disp(N(1,i));
    %S(1,i) = s;
    %T(1,i) = t;
    %R(1,i) = r;
    short_path = graphallshortestpaths(A,'Directed','false');
    clear A
    total = 0;  sum = 0;
    for j = 1:size(short_path,1)
        for k = j+1:size(short_path,2)
            sum = sum + short_path(j,k);
            total = total + 1;
        end
    end
    avg_short_path(1,i) = sum/total
    clear sum
    clear total
    clear short_path
end

