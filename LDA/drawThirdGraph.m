% Plot the clusters and the cluster centroids.
function [] = drawThirdGraph(ldaScore)
    figure;
    scatter(ldaScore(1:100,1), ldaScore(1:100,2),'Marker','x');
    hold on;
    scatter(ldaScore(101:200,1), ldaScore(101:200,2),'Marker','+');
    hold on;
    scatter(ldaScore(201:300,1), ldaScore(201:300,2), 'Marker','*');
    title 'LDA - MNIST digits';
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('One','Five','Eight','Location','NorthEast');
    hold off;
end