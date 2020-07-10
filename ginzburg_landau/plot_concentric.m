function B = plot_concentric(A,sn_ID,max_d)

hold on

n = size(A,1);
B = sparse(max_d+1,n);
B(1,1) = sn_ID;

% sn_ID is the start node ID
G = graph(A);
visited = [sn_ID];
N = neighbors(G,sn_ID);

queue = N;
%[no_neighbors, ~] = size(N);
%return_array = [no_neighbors];
visited = [visited; N];
for i=1:size(N,1)
    B(2,i) = N(i);
end

j = 3;

while size(N,1) ~= 0 && size(N,2) ~= 0
    
N = [];

	while size(queue,1) ~= 0 && size(queue,2) ~= 0

	node = queue(1,1);
    if size(queue,1) == 1
        queue = [];
    else
        queue = queue(2:end , 1);
    end
	new_neighbors = neighbors(G,node);
	[no_new_neighbors,~] = size(new_neighbors);
    
    not_visited_N = [];

		for i=1:no_new_neighbors
		temp = new_neighbors(i,1);

			if ismember(temp,visited) == 0
                not_visited_N = [not_visited_N; temp];
			end

        end
        
        N = [N; not_visited_N];
        visited = [visited; not_visited_N];

	end

	queue = N;
    for i=1:size(N,1)
        B(j,i) = N(i);
    end
    
    j = j+1;
    
end

end