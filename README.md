Image Classification & Image Retrieval by BOW 

1. Image Classification 

Image_Classification_By_BOW sử dụng để phân lớp ảnh bằng phương pháp BOW 
	- Tạo lập ImageDataStore
		imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
	- Tạo lập Training Set và Test Set
		[trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');
	- Tạo Bag of Word
		bag = bagOfFeatures(trainingSet);
	- Training 
		categoryClassifier = trainImageCategoryClassifier(imds,bag,'LearnerOptions',opts);
	- Đánh giá kết quả qua bộ Test
		confMatrix = evaluate(categoryClassifier,validationSet);
		mean(diag(confMatrix));
	- Input image mới để thử nghiệm thực tế
		img = imread(fullfile(rootFolder,'dolphin','image_0003.jpg'));
		[label, scores] = predict(categoryClassifier,img);
		categoryClassifier.Labels(label)

Image_Classification_By_CNN sử dụng để phân lớp ảnh bằng phương pháp Deep Learning
	- Tạo lập ImageDataStore
		imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
	- Tạo lập Training Set và Test Set
		[trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');
	- Tạo mạng Alex , trích xuất feature của Training Data Set (CNN)
		net = alexnet();
		featureLayer = 'fc7';
		trainingFeatures = activations(net, trainingSet, featureLayer, ...
    					'MiniBatchSize', 32, 'OutputAs', 'columns');
	- Sử dụng SVM để training mạng CNN
		classifier = fitcecoc(trainingFeatures, lblDataTrain, ...
    				'Learners', 'Linear', 'Coding', 'ordinal', 'ObservationsIn', 'columns');
	- Trích xuất feature của Test Data Set
		testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',32);

	- Đánh giá bộ Test
		predictedLabels = predict(classifier, testFeatures);

	- Xuất độ đánh giá Acc Acurancy
		confMat = confusionmat(testLabels, predictedLabels);
		confMat = bsxfun(@rdivide,confMat,sum(confMat,2));

	- Input image mới để thử nghiệm thực tế
		newImg = fullfile(rootFolder,'emu','image_0003.jpg');
		img = readAndPreprocessImage(newImg);
		imageFeature = activations(net, img, featureLayer);
		label = predict(classifier,imageFeature)

2. Image Retrieval
	- Tạo lập ImageDataStore
		imageDatastore(fullfile(rootFolder,categories),'LabelSource','foldernames');
	- Tạo Bag of Word
		bag = bagOfFeatures(imds);
	- Trích xuất chỉ số của ảnh trong BOW
		ImageIndex = indexImages(imds, colorBag);

	- Lấy hình ảnh cần tìm kiếm
		queryImage = readimage(imds, 120);

	- Tìm kiếm 20 ảnh có cùng thông tin
		[imageIDs, scores] = retrieveImages(queryImage, ImageIndex);

	- Hiển thị kết quả
		helperDisplayImageMontage(imds.Files(imageIDs))
