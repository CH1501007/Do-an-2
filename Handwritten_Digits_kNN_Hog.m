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
    featuresDataTrain = ExtractFeaturesHog(imgDataTrain);
    
    %%Build Model kNN
    Mdl= fitcknn(featuresDataTrain',lblDataTrain);
    
    %%Load Data Test
    strData = 't10k-images.idx3-ubyte';
    strDataLabel = 't10k-labels.idx1-ubyte';
    
    [imgDataTest, lblActualDataTest] = loadData(strData,strDataLabel);
    
    %%Extract features
    featuresDataTest = ExtractFeaturesHog(imgDataTest);
    
    %%Save result
    lblResult = predict(Mdl,featuresDataTest');
    nResult = (lblResult == lblActualDataTest);
    nCount=sum(nResult);
    fprintf('\nSo luong mau dung: %d\n',nCount);

end

