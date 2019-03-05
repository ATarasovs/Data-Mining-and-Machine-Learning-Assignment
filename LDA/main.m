% Prepare the environment
clc;
clear;

% load data
load ../AC50001_assignment2_data.mat;

% combine all data together
data = [digit_one digit_five digit_eight];
data = data';

dataLabels = [];

% Set labels for data
for n=1:size(data,1)
    if n <= 100
        dataLabels = [dataLabels;'1'];
    elseif n > 100 && n <= 200
        dataLabels = [dataLabels; '5'];
    else
        dataLabels = [dataLabels; '8'];
    end
end

% Assign labels to data
digit1 = data(dataLabels=='1',:);
digit5 = data(dataLabels=='5',:);
digit8 = data(dataLabels=='8',:);

% Calculate class means
mu1 = mean(digit1);
mu5 = mean(digit5);
mu8 = mean(digit8);

% Calculate verall mean
% mu = (mu1 + mu5 + mu8)./3;

% Calculate within class scatter matrix
sw = cov(digit1) + cov(digit5) + cov(digit8);
sw = sw + 0.00001*eye(size(sw));

v = inv(sw) * (mu1 - mu5 - mu8)';
ldaScore = data * v;

% classSize = 100;

% Calculate between class scatter matrix
% sb1 = classSize .* (mu1 - mu) * (mu1 - mu)';
% sb5 = classSize .* (mu5 - mu) * (mu5 - mu)';
% sb8 = classSize .* (mu8 - mu) * (mu8 - mu)';

% sb = sb1 + sb5 + sb8;

% Computing LDA projection
% ldaProjection = sw / sb;

% [v,d] = eigs(ldaProjection);

% ldaScore = data*v(:,[1 2]);

% Call function to perform k-means clustering
[grid, clusterAssignments] = setGrid(ldaScore);

% Function to plot cluster regions
drawFirstGraph(grid, clusterAssignments, ldaScore);

% Function to get stats of total sums of distances
[idx, c] = getStats(ldaScore);

% Function to plot the clusters and the cluster centroids
drawSecondGraph(idx, ldaScore, c);

drawThirdGraph(ldaScore);



