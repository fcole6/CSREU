loglog(N,T,'*-',N,E,'*-');
xlabel('Number of Nodes');
ylabel('Number of Edges');
title('Edge Count v. Node Count for Embedded Trees');
legend('Tree; m = 1','Ring; m \approx 0.4');