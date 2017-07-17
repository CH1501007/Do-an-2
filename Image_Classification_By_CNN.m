function Image_Classification_By_CNN()

rootFolder = fullfile('101_ObjectCategories');
categories={
'brontosaurus',     'dalmatian',        'flamingo',         'llama',            'panda',            'sea_horse',...        
'butterfly',      'dolphin',          'gerenuk',          'lobster',          'pigeon',           'starfish',...         
'Leopards',       'cougar',           'dragonfly',        'hawksbill',        'mayfly',           'platypus',         'stegosaurus',...      
'ant' ,           'crab',             'hedgehog',         'nautilus',         'rhino',            'tick',...             
'bass',           'crayfish',         'elephant',         'ibis',             'octopus',          'rooster',          'trilobite',...        
'beaver',         'crocodile',        'emu',              'kangaroo',         'okapi',            'scorpion'        
};
imds = imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);

[trainingSet, testSet] = splitEachLabel(imds, 0.7, 'randomize');

net = alexnet();
featureLayer = 'fc7';
trainingFeatures = activations(net, trainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

lblDataTrain = trainingSet.Labels;

classifier = fitcecoc(trainingFeatures, lblDataTrain, ...
    'Learners', 'Linear', 'Coding', 'denserandom', 'ObservationsIn', 'columns');

% save('modal_cnn.mat','classifier');
testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',32);

predictedLabels = predict(classifier, testFeatures);

% Get the known labels
testLabels = testSet.Labels;

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2));

mean(diag(confMat))
% load('modal_cnn.mat');
newImg = fullfile(rootFolder,'emu','image_0003.jpg');
img = readAndPreprocessImage(newImg);
imageFeature = activations(net, img, featureLayer);

label = predict(classifier,imageFeature)

end