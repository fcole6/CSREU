function [return_array,p,error] = dim_array(G,sn_ID)

% sn_ID is the start node ID

visited = [sn_ID];
N = neighbors(G,sn_ID);

queue = N;
[no_neighbors, ~] = size(N);
return_array = [no_neighbors];
% no_neighbors = 0;
visited = [visited; N];
counter = 0;

while size(N,1) ~= 0 && size(N,2) ~= 0     %% stops when queue becomes empty

N = [];     %% resets N from the previoius step

	while size(queue,1) ~= 0 && size(queue,2) ~= 0 

	node = queue(1,1);
    if size(queue,1) == 1           %% pick a node from the queue; remove it
        queue = [];
    else                                
        queue = queue(2:end , 1);
    end
	new_neighbors = neighbors(G,node);      %% get neighbors of just selected node
	[no_new_neighbors,~] = size(new_neighbors);
    
    not_visited_N = [];     %% counts the just vistited neighbors of just selected node

		for i=1:no_new_neighbors
		temp = new_neighbors(i,1);

			if ismember(temp,visited) == 0
                not_visited_N = [not_visited_N; temp];
			end

        end
        counter = counter + size(not_visited_N,1);
        N = [N; not_visited_N];    %% 
        visited = [visited; not_visited_N];  %% add just visited nodes to visited

	end

	queue = N;      %% put just visited nodes in queue, so we can repeat the process starting from them
	[no_neighbors, ~] = size(counter);
    % [no_neighbors, ~] = size(N);        %% count the number of just visited nodes
	return_array = [return_array; counter];        %% next entry in the returned vector is the number of nodes visited during previous iteration
	no_neighbors = 0;       %% reset the count, reset the while loop

end
g = (1:length(return_array))';
p = polyfit(log(g),log(return_array),1);
y = polyval(p,log(g));
err = abs(y-log(return_array));
error=mean(err);
end