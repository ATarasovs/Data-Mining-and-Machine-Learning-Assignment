% Partition the data into two clusters, and choose 
% the best arrangement out of five initializations. 
% Display the final output.
function [idx,c] = getStats(ldaScore)
    opts = statset('Display','final');
    [idx, c] = kmeans(ldaScore,3,'Distance','cityblock',...
        'Replicates',5,'Options',opts);
end

