% Prepare the environment
clc;
clear;

% load data
load ../AC50001_assignment2_data.mat;

% combine all data together
data = [digit_one digit_five digit_eight];
data = data';

% Function to calculate PCA score for 2 dimensions
pcaScore = getPcaScore(data);

% Call function to perform k-means clustering
[grid, clusterAssignments] = setGrid(pcaScore);

% Function to plot cluster regions
drawFirstGraph(grid, clusterAssignments, pcaScore);

% Function to get stats of total sums of distances
[idx, c] = getStats(pcaScore);

% Function to plot the clusters and the cluster centroids
drawSecondGraph(idx, pcaScore, c);

% Function to plot data points after PCA projection
drawThirdGraph(pcaScore);