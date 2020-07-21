

loglog(N,S,'*-r',N,T,'*-g',N,E,'*-b');
xlabel('Number of Nodes','Interpreter','latex');
ylabel('Number of Edges','Interpreter','latex');
title('Tree v. Ring Edge Contribution for Embedded Trees','Interpreter','latex');
legend('shared edges','excess tree edges','excess ring edges','Interpreter','latex');