function [pcaScore] = getPcaScore(data)
   
    % Produce a mean vector from data
    meanData = mean(data);

    % Produce zero mean data matrix
    data = data - repmat(meanData, size(data,1), 1);
    
    % Calculate covariance matrix
    covariance = cov(data);

    % Calculate eigenvalues and eigenvectors
    [v,d] = eigs(covariance);

    % Calculate PCA score
    pcaScore = data*v(:,1:2);
end

