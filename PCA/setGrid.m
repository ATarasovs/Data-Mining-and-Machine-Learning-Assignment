% Perform k-means clustering, set grid, 
% and assign each node to the closest centroid
function [grid, clusterAssignments] = setGrid(pcaScore)

    rng(1); % For reproducibility 
    
    % Perform k-means clustering to partition the observations
   [idx, C] = kmeans(pcaScore,3);

    minScoreX = min(pcaScore(:,1));
    maxScoreX = max(pcaScore(:,1));
    minScoreY = min(pcaScore(:,2));
    maxScoreY = max(pcaScore(:,2));
    
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

