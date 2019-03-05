% Plot the clusters and the cluster centroids.
function [] = drawSecondGraph(idx, pcaScore, c)
    figure;
    plot(pcaScore(idx==1,1),pcaScore(idx==1,2),'r.','MarkerSize',12)
    hold on
    plot(pcaScore(idx==2,1),pcaScore(idx==2,2),'g.','MarkerSize',12)
    hold on
    plot(pcaScore(idx==3,1),pcaScore(idx==3,2),'b.','MarkerSize',12)
    plot(c(:,1),c(:,2),'kx',...
         'MarkerSize',15,'LineWidth',3)
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NorthEast');
    title 'PCA - MNIST digits';
    hold off
end