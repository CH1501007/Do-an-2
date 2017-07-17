function Image_Classification_By_BOG()
%%Load image data train 
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

[trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');

bag = bagOfFeatures(trainingSet, 'BlockWidth', [64 96 128 256]);

% save('bagFeatures.mat', 'bag');
% load('bagFeatures.mat');
categoryClassifier = trainImageCategoryClassifier(imds,bag);
% save('categoryClassifier.mat','categoryClassifier');
% load('categoryClassifier.mat');
confMatrix = evaluate(categoryClassifier,validationSet);
mean(diag(confMatrix));

img = imread(fullfile(rootFolder,'dolphin','image_0003.jpg'));
[label, scores] = predict(categoryClassifier,img);
categoryClassifier.Labels(label)
end

