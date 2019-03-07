% Prepare the environment
clc;
clear;

% load data
load ../AC50001_assignment2_data.mat;

% Seperate data in two classes
data = [digit_one digit_five digit_eight];
dataLabels = [];

%Assign labels
for n = 1:size(data, 2)
    if n <= 100
        dataLabels = [dataLabels; '1'];
    end
    if n > 100 && n <= 200
        dataLabels = [dataLabels; '5'];
    end
    if n > 200
        dataLabels = [dataLabels; '8'];
    end
end

% Assign classes
dataClasses = [];
for n = 1:max(size(dataLabels))
    dataClasses = [dataClasses; isequal(dataLabels(n), '5')];
end

% Split data for 2-fold cross validation
cvo = cvpartition(dataClasses,'k',5);

% Get ndexes for training and testing samples
trIdx = cvo.training(1); 
teIdx = cvo.test(1); 

% Training label ground truth
trainingLabelVector = dataClasses(trIdx); 

% Training data matrix
trainingInstanceMatrix = data(:,trIdx); 

% Test label ground truth
testLabelVector = dataClasses(teIdx); 

% Test data matrix
testInstanceMatrix = data(:,teIdx);

% Train model using RBF kernel
% model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 1 -g 0.07');
% model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 1 -g 0.07');
% model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 1 -g 0.01');
% model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 1 -g 0.20');
% model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 1 -g 0.99');

% Train model using linear kernel
model = svmtrain(trainingLabelVector, trainingInstanceMatrix', '-t 0');

% Classification on test data
decValues = svmpredict(testLabelVector, ...
                                   testInstanceMatrix', model);
                               
% Draw ROC curve
[X,Y,T,AUC] = perfcurve(testLabelVector, decValues, false);
figure;
plot(X,Y);
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC Curve for Linear SVM')
hold on;

% Plot confusion matrix
figure;
plotconfusion(testLabelVector',predictLabel');
hold off;