% Plot the clusters and the cluster centroids.
function [] = drawSecondGraph(idx, ldaScore, c)
    figure;
    plot(ldaScore(idx==1,1),ldaScore(idx==1,2),'r.','MarkerSize',12)
    hold on
    plot(ldaScore(idx==2,1),ldaScore(idx==2,2),'g.','MarkerSize',12)
    hold on
    plot(ldaScore(idx==3,1),ldaScore(idx==3,2),'b.','MarkerSize',12)
    plot(c(:,1),c(:,2),'kx',...
         'MarkerSize',15,'LineWidth',3)
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NorthEast');
    title 'LDA - MNIST digits'
    hold off
end