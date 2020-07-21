function return_array = dim_array(G,sn_ID)

% sn_ID is the start node ID

visited = [sn_ID];
N = neighbors(G,sn_ID);

queue = N;
[no_neighbors, ~] = size(N);
return_array = [no_neighbors];
visited = [visited; N];

while size(N,1) ~= 0 && size(N,2) ~= 0 %% stops when queue becomes empty

N = [];%% resets N from the previoius step

	while size(queue,1) ~= 0 && size(queue,2) ~= 0

	node = queue(1,1);%% pick a node from the queue; remove it
    if size(queue,1) == 1
        queue = [];
    else
        queue = queue(2:end , 1);
    end
	new_neighbors = neighbors(G,node);%% get neighbors of just selected node
	[no_new_neighbors,~] = size(new_neighbors);
    
    not_visited_N = [];

		for i=1:no_new_neighbors
		temp = new_neighbors(i,1);

			if ismember(temp,visited) == 0
                not_visited_N = [not_visited_N; temp];%% counts the just vistited neighbors of just selected node
			end

        end
        
        N = [N; not_visited_N];
        visited = [visited; not_visited_N];%% add just visited nodes to visited

	end

	queue = N;%% put just visited nodes in queue, so we can repeat the process starting from them
	[temp, ~] = size(N); %% count the number of just visited nodes
    no_neighbors = no_neighbors + temp;%% next entry in the returned vector is the number of nodes visited during previous iteration
	return_array = [return_array; no_neighbors]; %% reset the count, reset the while loop

end

end