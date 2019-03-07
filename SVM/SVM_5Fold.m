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
[linearX,linearY,linearT,linearAUS] = perfcurve(testLabelVector, ...
                        linearScore(:,CompactSVMLinearModel.ClassNames),'1');

                    
% Train model using rbf kernel
rbfModel = fitcsvm(trainingInstanceMatrix, trainingLabelVector,...
                        'KernelFunction','rbf');
crossValRbfModel = crossval(rbfModel, 'KFold', 5);
CompactSVMRbfModel = crossValRbfModel.Trained{1};
rbfAccuracy = 1 - kfoldLoss(crossValRbfModel, 'LossFun', 'ClassifError');
[rbfLabel,rbfScore] = predict(CompactSVMRbfModel,testInstanceMatrix);
[rbfX,rbfY,rbfT,rbfAUC] = perfcurve(testLabelVector, ...
                        rbfScore(:,CompactSVMRbfModel.ClassNames),'1');

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
plot(rbfX,rbfY)
legend('Support Vector Machines','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curve for SVM with RBF Kernel')

% Plot confusion matrix for SVM with RBF kernel
figure;
plotconfusion(testLabelVector',rbfLabel');
title('Confusion matrix for SVM with RBF Kernel');

% Create results table
rbfReultsTable = table(testLabelVector,double(rbfLabel),linearScore(:,2),'VariableNames',...
    {'TrueLabel','PredictedLabel','Score'});

