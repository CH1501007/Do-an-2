function Handwritten_Digits_Bag_of_Features()
%%Load image data train 
rootFolder = fullfile('101_ObjectCategories');
categories={
'brontosaurus',     'dalmatian',        'flamingo',         'llama',            'panda',            'sea_horse',...        
'butterfly',      'dolphin',          'gerenuk',          'lobster',          'pigeon',           'starfish',...         
'Leopards',       'cougar',           'dragonfly',        'hawksbill',        'mayfly',           'platypus',         'stegosaurus',...      
'ant' ,           'crab',             'electric_guitar',  'hedgehog',         'nautilus',         'rhino',            'tick',...             
'bass',           'crayfish',         'elephant',         'ibis',             'octopus',          'rooster',          'trilobite',...        
'beaver',         'crocodile',        'emu',              'kangaroo',         'okapi',            'scorpion'        
};
imds = imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
tbl1 = countEachLabel(imds);
minSetCount = min(tbl1{:,2});

% [trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');

% bag = bagOfFeatures(imds);
% save('bagFeatures.mat', 'bag');
load('bagFeatures.mat');
categoryClassifier = trainImageCategoryClassifier(imds,bag);
save('categoryClassifier.mat',categoryClassifier);
load('categoryClassifier.mat');
% confMatrix = evaluate(categoryClassifier,validationSet);
% mean(diag(confMatrix));

img = imread(fullfile(rootFolder,'dolphin','image_0003.jpg'));
[label, scores] = predict(categoryClassifier,img);
categoryClassifier.Labels(label)
end

