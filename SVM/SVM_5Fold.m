% Prepare the environment
clc;
clear;

% load data
load ../AC50001_assignment2_data.mat;

% Combine all the data together
data = [digit_one digit_five digit_eight];

%Assign labels
dataLabels = [];
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

% Divide data in training and testing samples
cvo = cvpartition(dataClasses,'k',4);

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

% Train model using linear kernel
linearModel = fitcsvm(trainingInstanceMatrix, trainingLabelVector,...
                        'KernelFunction','linear');
crossValLinearModel = crossval(linearModel, 'KFold', 5);
CompactSVMLinearModel = crossValLinearModel.Trained{1};
linearAccuracy = 1 - kfoldLoss(crossValLinearModel, 'LossFun', 'ClassifError');
[linearLabel,linearScore] = predict(CompactSVMLinearModel,testInstanceMatrix);
[linearX,linearY,linearT,linearAUC] = perfcurve(testLabelVector, ...
                        linearScore(:,CompactSVMLinearModel.ClassNames),'1');
          
% Train model using rbf kernel
kFold = 5;
rbfModel = fitcsvm(trainingInstanceMatrix, trainingLabelVector,...
                'KernelFunction','rbf', 'KernelScale', 10);
crossValRbfModel = crossval(rbfModel, 'KFold', kFold);
bestAccuracy = 0;
maxKernelScale = 30;

for n = 1:kFold
    CompactSVMRbfModel = crossValRbfModel.Trained{n};
    rbfModelAccuracy = 1 - kfoldLoss(crossValRbfModel, 'LossFun', 'ClassifError');
    [rbfLabel,rbfScore] = predict(CompactSVMRbfModel,testInstanceMatrix);
    [rbfX,rbfY,rbfT,rbfAUC] = perfcurve(testLabelVector, ...
                            rbfScore(:,CompactSVMRbfModel.ClassNames),'1');
    rbfTestAccuracy = sum(testLabelVector==rbfLabel)/numel(testLabelVector);
    if (rbfTestAccuracy > bestAccuracy)
        bestModel = CompactSVMRbfModel;
        bestRbfLabel = rbfLabel;
        bestRbfScore = rbfScore;
        bestAccuracy = rbfTestAccuracy;
        bestRbfX = rbfX;
        bestRbfY = rbfY;
        bestRbfT = rbfT;
        bestRbfAUC = rbfAUC;
        bestRbfModelAccuracy = rbfModelAccuracy;
    end
    
end

% Plot ROC curve for SVM with linear kernel
figure
plot(linearX,linearY)
legend('Support Vector Machines','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curve for SVM with Linear Kernel')

% Plot confusion matrix for SVM with linear kernel
figure;
plotconfusion(testLabelVector',linearLabel');
title('Confusion matrix for SVM with Linear Kernel');

% Create results table
linearReultsTable = table(testLabelVector,double(linearLabel),linearScore(:,2),'VariableNames',...
    {'TrueLabel','PredictedLabel','Score'});

% Plot ROC curve for SVM with RBF kernel
figure
plot(bestRbfX,bestRbfY)
legend('Support Vector Machines','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curve for SVM with RBF Kernel')

% Plot confusion matrix for SVM with RBF kernel
figure;
plotconfusion(testLabelVector',bestRbfLabel');
title('Confusion matrix for SVM with RBF Kernel');

% Create results table
rbfReultsTable = table(testLabelVector,double(bestRbfLabel),bestRbfScore(:,2),'VariableNames',...
    {'TrueLabel','PredictedLabel','Score'});

