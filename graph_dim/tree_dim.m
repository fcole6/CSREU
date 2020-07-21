addpath('C:/Users/Franck/iCloudDrive/reu_2020/code/CSREU/graph_structs');

A = tree_embedded_in_ring(350549,2);

d = get_tree_ring_data(A);

%----------------------------------------------

function v = get_tree_ring_data(A)
tic
    %input adjacency matrix A
    n = size(A,1);
    %output with data we wish to record
    v = zeros(1,5);
    %dimension
    v(1,1) = n;
    arry = calculate_tree_ring_dim(A);
    arry = log(arry);
    x = [2:size(arry)-1];
    x = log(x);
    x_0 = find(x>5.945,1);
    x = x(1:x_0);
    arry = arry(2:size(x,2)+1);
    x = x';
    f = polyfit(x,arry,1);
    %slope
    slope = f(1); v(1,2) = slope;
    polyfit_vals = polyval(f,x);
    figure(2)
    plot(x,arry,'o-',x,polyfit_vals);
    title("Dimension of regular tree");
    xlabel("log(n)");
    ylabel("log(V)");
    v(2)
    %error
    toc
    error = abs(polyfit_vals - arry);
    avg_e = mean(error); v(1,3) = avg_e;
    %call perturbation function here, return [M,avg_p]
    %[x,d,s] = perturb(A); v(1,4) = d; v(1,5) = s;
end

%----------------------------------------------

function return_array = calculate_tree_ring_dim(A)
G = graph(A);
%figure(1)
%h = plot(G,'Layout','circle');
%c = gray(6);

sn_ID = 1;
    
visited = [sn_ID];
N = neighbors(G,sn_ID);

%c_j = c(1,:);
%highlight(h,sn_ID,'NodeColor',c_j);

%pause(2);

queue = N;
[no_neighbors, ~] = size(N);
return_array = [no_neighbors];
visited = [visited; N];

%c_j = c(2,:);
%for i=1:no_neighbors
%highlight(h,N(i),'NodeColor',c_j);
%end

%pause(2);

%j = 3;

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
                %c_j = c(j,:);
                %highlight(h,temp,'NodeColor',c_j);
			end

        end
        
        N = [N; not_visited_N];
        visited = [visited; not_visited_N];

    end
    
    %pause(2);
    
    %j = j+1;
    
    %if j == 7
        %j = 1;
    %end

	queue = N;
	[temp, ~] = size(N);
    no_neighbors = no_neighbors + temp;
	return_array = [return_array; no_neighbors];

end

end