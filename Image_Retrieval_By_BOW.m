function Image_Retrieval_By_BOW()
    %%Load Data Train
rootFolder = '101_ObjectCategories';
categories={
'brontosaurus',     'dalmatian',        'flamingo',         'llama',            'panda',            'sea_horse',...        
'butterfly',      'dolphin',          'gerenuk',          'lobster',          'pigeon',           'starfish',...         
'Leopards',       'cougar',           'dragonfly',        'hawksbill',        'mayfly',           'platypus',         'stegosaurus',...      
'ant' ,           'crab',             'hedgehog',         'nautilus',         'rhino',            'tick',...             
'bass',           'crayfish',         'elephant',         'ibis',             'octopus',          'rooster',          'trilobite',...        
'beaver',         'crocodile',        'emu',              'kangaroo',         'okapi',            'scorpion'        
};
    %%Extract features
imds = imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
    
    %%Load Data Train
% numel(imds.Files);
% 
% colorBag = bagOfFeatures(imds);
% save('colorBag.mat', 'colorBag');
load('colorBag.mat');
ImageIndex = indexImages(imds, colorBag);

% save('ImageIndex.mat', 'ImageIndex')
queryImage = readimage(imds, 120);

figure
imshow(queryImage)

% Search for the top 20 images with similar content
[imageIDs, scores] = retrieveImages(queryImage, ImageIndex);

% Display results using montage. Resize images to thumbnails first.
helperDisplayImageMontage(imds.Files(imageIDs))

% Lower WordFrequencyRange
ImageIndex.WordFrequencyRange = [0.01 0.2];

% Re-run retrieval
[imageIDs, scores] = retrieveImages(queryImage, ImageIndex);

% Show results
helperDisplayImageMontage(imds.Files(imageIDs))
end

