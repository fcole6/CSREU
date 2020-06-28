function A = hexagon_graph(n)
old = n;
new = old;
while (new > floor(sqrt(old)))
    if mod(new,2) ~= 0
        break;
    else
        new = new / 2;
    end
end
m = new; n = old/new;
e = ones(m);
A_1 = spdiags([e e e], -1:1, m,m) - eye(m);
A = kron(eye(n), A_1);
up = zeros(1,old);
for j=2:n*2:old
    i = j;
    while 
end