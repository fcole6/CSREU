%sample tree
A = tree_embedded_in_ring(101,2);
get_tree_ring_data(A);

%----------------------------------------------

%calls the dimension coloring of the graph and gets dim data
%makes dimension plot

function get_tree_ring_data(A)
tic
    %input adjacency matrix A
    n = size(A,1);
    %get dimension
    arry = calculate_tree_ring_dim(A);
    arry = log(arry);
    x = 1:size(arry,1);
    x = log(x);
    figure(2)
    plot(x,arry,'o-');
    title("Dimension of regular tree");
    xlabel("log(n)");
    ylabel("log(V)");
    toc
end

%----------------------------------------------

%makes dimension coloring while calculating dimension
%very similar to dim_array code with this extra functionality
%------see dim_array code to see comments on how code computes dimension
%function returns the dimension data to use in previous function

function return_array = calculate_tree_ring_dim(A)

%makes graph object
G = graph(A);

figure(1)
h = plot(G,'Layout','circle');
%sets the color scheme of the coloring, can modify
%for a rainbow coloring, try (c=hsv(no_colors))
%can update no_colors as desired, the rest of code should work fine
no_colors = 6;
c = gray(no_colors);

%starting node id; in the case of tree rings, the root has ID 1
sn_ID = 1;
    
visited = [sn_ID];
N = neighbors(G,sn_ID);

%gets the RGB values for the first color in the scheme
c_j = c(1,:);
%gives that color to starting node in the coloring
highlight(h,sn_ID,'NodeColor',c_j);

pause(0.5);

queue = N;
[no_neighbors, ~] = size(N);
return_array = [no_neighbors];
visited = [visited; N];

%gets the RGB values for the first color in the scheme
c_j = c(2,:);
%gives that color to all neighbors of starting node
for i=1:no_neighbors
highlight(h,N(i),'NodeColor',c_j);
end

pause(0.5);

%keep track of the color we want to access in the scheme
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

    %get jth color in the scheme "c"
    c_j = c(j,:);
    
        %for nodes attained at this level
        %check that they aren't visited
        %if not, color those nodes the jth color
		for i=1:no_new_neighbors
		temp = new_neighbors(i,1);
            if ismember(temp,visited) == 0
                not_visited_N = [not_visited_N; temp];
                highlight(h,temp,'NodeColor',c_j);
            end

        end
        
        N = [N; not_visited_N];
        visited = [visited; not_visited_N];

    end
    
    pause(0.5);
    
    %update j
    j = j+1;
    
    %if we've exceeded the number of colors in the scheme,
    %we wish to start back at color 1
    if j == no_colors + 1
        j = 1;
    end

	queue = N;
	[temp, ~] = size(N);
    no_neighbors = no_neighbors + temp;
	return_array = [return_array; no_neighbors];

end

end