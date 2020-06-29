function [return_array,g] = dim_array(G,sn_ID)

% sn_ID is the start node ID

visited = [sn_ID];
N = neighbors(G,sn_ID);

queue = N;
[no_neighbors, ~] = size(N);
return_array = [no_neighbors];
visited = [visited; N];

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
	[temp, ~] = size(N);
    no_neighbors = no_neighbors + temp;
	return_array = [return_array; no_neighbors];

end
g = (1:length(return_array))';
return_array = log(return_array);
g = log(g);
m = length(g);
g = g(10:end);
return_array = return_array(10:end);
%for i = 1:m
    %if floor(g(i)/log(4)) == g(i)/log(4)
        %g2 = [g2; g(i)];
        %ret2 = [ret2; return_array(i)];
    %end
%end
%g = g(ceil(m/3):floor(2*m/3));
%return_array = return_array(ceil(m/3):floor(2*m/3));
end