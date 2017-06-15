function [featuresDataTrain] = ExtractFeaturesHog(imgDataTrain)

    [featureVector, hogVisualization] = extractHOGFeatures(imgDataTrain);
    nSize = length(featureVector);
    nTrainData = size(imgDataTrain,2);
    featuresDataTrain = zeros(nSize,nTrainData);
    parfor i=1:nTrainData
        imgI1D = imgDataTrain(:,i);
        imgI2D = reshape(imgI1D,28,28);
        featuresDataTrain(:,i) = extractHOGFeatures(imgI2D,'CellSize',[2 2]);
    end
end

