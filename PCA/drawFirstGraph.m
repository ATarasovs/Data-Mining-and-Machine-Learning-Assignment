% Plot the cluster regions
function [] = drawFirstGraph(grid, clusterAssignments, pcaScore)
    figure;
    gscatter(grid(:,1),grid(:,2),clusterAssignments,...
        [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
    hold on;
    plot(pcaScore(:,1),pcaScore(:,2),'k*','MarkerSize',5);
    title 'MNIST digits';
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('One','Five','Eight','Data points','Location','NorthEast');
    hold off;    
end

