% Perform k-means clustering, set grid, 
% and assign each node to the closest centroid
function [grid, clusterAssignments] = setGrid(ldaScore)

    % Perform k-means clustering to partition the observations
   [idx, C] = kmeans(ldaScore,3);

    minScoreX = min(ldaScore(:,1));
    maxScoreX = max(ldaScore(:,1));
    minScoreY = min(ldaScore(:,2));
    maxScoreY = max(ldaScore(:,2));
    
    % Dimension 1
    dimensionX = minScoreX:0.01:maxScoreX;
    % Dimension 2
    dimensionY = minScoreY:0.01:maxScoreY;

    % Set mesh grid
    [gridX,gridY] = meshgrid(dimensionX,dimensionY);
    
    % Define a fine grid on the plot
    grid = [gridX(:),gridY(:)];

    % Assigns each node in the grid to the closest centroid
    % Only one iteration (better performance)
    clusterAssignments = kmeans(grid,3,'MaxIter',1,'Start',C); 
end

