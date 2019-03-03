% Partition the data into two clusters, and choose 
% the best arrangement out of five initializations. 
% Display the final output.
function [idx,c] = getStats(pcaScore)
    opts = statset('Display','final');
    [idx, c] = kmeans(pcaScore,3,'Distance','cityblock',...
        'Replicates',5,'Options',opts);
end

