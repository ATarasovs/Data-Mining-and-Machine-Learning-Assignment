% Plot the cluster regions
function [] = drawFirstGraph(grid, clusterAssignments, pcaScore)
    figure;
    gscatter(grid(:,1),grid(:,2),clusterAssignments,...
        [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
    hold on;
    plot(pcaScore(:,1),pcaScore(:,2),'k*','MarkerSize',5);
    title 'PCA - MNIST digits';
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('Region 1','Region 2','Region 3','Data points','Location','NorthEast');
    hold off;    
end

