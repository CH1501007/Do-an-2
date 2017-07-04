function Handwritten_Digits_kNN_Hog()
    %%Load Data Train
strData = '101_ObjectCategories';
categories={
'brontosaurus',     'dalmatian',        'flamingo',         'llama',            'panda',            'sea_horse',...        
'butterfly',      'dolphin',          'gerenuk',          'lobster',          'pigeon',           'starfish',...         
'Leopards',       'cougar',           'dragonfly',        'hawksbill',        'mayfly',           'platypus',         'stegosaurus',...      
'ant' ,           'crab',             'electric_guitar',  'hedgehog',         'nautilus',         'rhino',            'tick',...             
'bass',           'crayfish',         'elephant',         'ibis',             'octopus',          'rooster',          'trilobite',...        
'beaver',         'crocodile',        'emu',              'kangaroo',         'okapi',            'scorpion'        
};
    %%Extract features
imds = imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
    
    %%Load Data Train
  imds.ReadFcn = @(filename)readAndPreprocessImage2(filename);

end

