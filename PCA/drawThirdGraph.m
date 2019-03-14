% Function to plot data points after PCA projection
function [] = drawThirdGraph(pcaScore)
    figure;
    scatter(pcaScore(1:100,1), pcaScore(1:100,2),'Marker','x');
    hold on;
    scatter(pcaScore(101:200,1), pcaScore(101:200,2),'Marker','+');
    hold on;
    scatter(pcaScore(201:300,1), pcaScore(201:300,2), 'Marker','*');
    title 'PCA - MNIST digits';
    xlabel 'Dimension 1';
    ylabel 'Dimension 2';
    legend('One','Five','Eight','Location','NorthEast');
    hold off;
end