function [pcaScore] = getPcaScore(data)

    % get mean values for 
    meanData = mean(data);

    newData = [];

    for n = 1:300
        for k = 1:784
            newData(n,k) = data(n,k) - meanData(n);
        end
    end

    covariance = cov(newData);

    [v,d] = eigs(covariance);

    pcaScore = newData*v(:,[1 2]);
end

