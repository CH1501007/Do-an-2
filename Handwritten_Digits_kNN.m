function Handwritten_Digits_kNN()
%%Load image data train 
load('train_32x32.mat');
imageDataTrain = X;
lblDataTrain = y;
    
load('test_32x32.mat')
imageDataTest = X;
lblDataTest = y;

featuresDataTrain = ExtractFeaturesHog(imageDataTrain);

Mdl= fitcknn(featuresDataTrain',lblDataTrain, 'NumNeighbors',10, 'NSMethod','kdtree');
featuresDataTest = ExtractFeaturesHog(imageDataTest);

lblResult = predict(Mdl,featuresDataTest');
 nResult = (lblResult == lblDataTest);
nCount=sum(nResult);
fprintf('\nSo luong mau dung: %d\n',nCount);

end



