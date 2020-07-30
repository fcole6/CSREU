function return_array = dim_array(G,sn_ID)

% sn_ID is the start node ID

visited = [sn_ID]; %%vector of nodes already visited
%%updates every iteration
N = neighbors(G,sn_ID); %%N is the array of unvisited nodes

queue = N; %%queue is a queue of the neighbors at a given iteration
[no_neighbors, ~] = size(N);
return_array = [no_neighbors]; %%array that is returned:
%%number of total nodes reached for each iteration
visited = [visited; N];

while size(N,1) ~= 0 && size(N,2) ~= 0 %%while N not empty

N = [];%% resets N from the previous step

	while size(queue,1) ~= 0 && size(queue,2) ~= 0 %%while queue not empty

	node = queue(1,1); %%pop the queue
    if size(queue,1) == 1 %%taking care of edge case
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
                not_visited_N = [not_visited_N; temp];
                %%counts the not previously vistited neighbors of node
                %%popped from queue
			end

        end
        
        N = [N; not_visited_N];
        visited = [visited; not_visited_N];%% add just visited nodes to visited

	end

	queue = N;%% put just visited nodes in queue, so we can repeat the 
    %%process starting from them
	[temp, ~] = size(N); %% count the number of just visited nodes
    no_neighbors = no_neighbors + temp;%% next entry in the returned vector
    %%is the number of nodes visited during previous iteration
	return_array = [return_array; no_neighbors]; %% reset the count, reset 
    %%the while loop

end

end