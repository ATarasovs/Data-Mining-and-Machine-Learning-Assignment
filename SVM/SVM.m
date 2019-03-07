% Prepare the environment
clc;
clear;

% load data
load ../AC50001_assignment2_data.mat;

% Seperate data in two classes
data = [digit_one digit_five digit_eight];
% data(300:784,:) = [];
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

cvo = cvpartition(dataClasses,'k',10);

% Get indexes for training and testing samples
trIdx = cvo.training(1); 
teIdx = cvo.test(1); 

% Training label ground truth
trainingLabelVector = dataClasses(trIdx); 

% Training data matrix
trainingInstanceMatrix = data(:,trIdx)'; 

% Test label ground truth
testLabelVector = dataClasses(teIdx); 

% Test data matrix
testInstanceMatrix = data(:,teIdx)';

trainingLabelVector=logical(trainingLabelVector);
model = fitcsvm(trainingInstanceMatrix, trainingLabelVector,'KernelFunction','linear');
crossValModel = crossval(model, 'KFold', 5);
CompactSVMModel = crossValModel.Trained{1};
accuracy = 1 - kfoldLoss(crossValModel, 'LossFun', 'ClassifError');
[label,score] = predict(CompactSVMModel,testInstanceMatrix);
[x1,y1,t1s,auc1] = perfcurve(testLabelVector,score(:,CompactSVMModel.ClassNames),'1');

figure
hold on
plot(x1,y1)
legend('Support Vector Machines','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curve for SVM')
hold off

figure;
plotconfusion(testLabelVector',label');
hold off;

