function [A,G] = RegSWNetwork(N,k,m)

% Only wrote this after the REU finished, as an idea for another way to 
% combine small-world graphs with regular trees (haven't totally debugged
% it, so feel free to play around with it).

% Creates a small-world network on N vertices with approx log(N)/log(m)
% random edges, and with distance between 'head vertices' of the random
% edges increasing by powers of m

% Starting graph is a 2k-regular ring lattice (a ring with each node
% connected to its 2k-nearest neighbors)


% --------------- Generates a 2k-regular ring lattice ----------------------

B = zeros(N,2*k+1);
e = ones(N,1);

for i = 1:k
    B(:,i) = e;
     B(:,i+k+1) = e;
end


A = spdiags(B,-k:k,N,N);

for i = 1:k
    for j = 1:i
        A(j,N-i+j) = 1; A(N-i+j,j) = 1;
    end
end

% ------------------------------------------------------------------------

y = 1; % index of 'head' of random edge (tail tbd randomly), occurs on powers of m
c = 1; % count variable, used to increase y after each iteration of while loop

while y < ceil(N/2)-1
    l = N-2*y+1;
    x = randi(l); % tail of random edge is therefore y+x, which satisfies y < y+x < ceil(N/2)
    x2 = randi(l);
    if A(y,x+y) == 1 % make sure y, x+y aren't already connected
        continue
    end
    if A(N-y+1,N-y+1-x2) == 1
        continue
    end
    A(y,x+y) = 1; A(x+y,y) = 1; %% create random edge moving CCW around ring
    A(N-y+1,N-y+1-x2) = 1; A(N-y+1-x2,N-y+1) = 1; % random edge moving CW around ring
    
    r1 = randi(2);
    r2 = randi(k);
    
    if y > k
    a =((-1)^r1)*r2;
    else
        a = r2;
    end
    
    A(y,y+a) = 0; A(y+a,y) = 0; % remove nearby edge from rewired vertex, (second part of the rewiring process
   
    A(N-y+1,N-y+1-a) = 0; A(N-y+1-a,N-y+1) = 0;
    
    y = y+floor(m^c); % take a step m^c vertices along the ring
    c = c+1;
end

G = graph(A);

end