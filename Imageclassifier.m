%% Initialization
clear ; close all; clc

%% =============== Part 1: Loading Data ================
 
fprintf('Loading Data \n');

% n is the number of types of images

n = 3;

im = imageDatastore('photos','IncludeSubfolders',true,'LabelSource','foldernames');
% Resize the images to the input size of the net
im.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
[Train ,Test] = splitEachLabel(im,0.8,'randomized');


fprintf('Program paused. \nYou can press stop button manually on tranining plot(on top right corner besides number of iterations) once accuracy reaches upto desired level. Press enter to continue.\n');
pause;
%% =============== Part 2: Training Data ================

 fc = fullyConnectedLayer(n);
 net = alexnet;
 ly = net.Layers;
 ly(23) = fc;
 cl = classificationLayer;
 ly(25) = cl; 
 % options for training the net if your newnet performance is low decrease
 % the learning_rate
 learning_rate = 0.0001;
 opts = trainingOptions("adam","InitialLearnRate",learning_rate,'MiniBatchSize',64,'Plots','training-progress');
 [newnet,info] = trainNetwork(Train, ly, opts);
 fprintf('Program paused. Press enter to continue.\n');
 pause;
 %% =============== Part 3: Predicting accuracy for Test Set ================

 fprintf('Predicting accuracy for Test Set \n');
 [predict,scores] = classify(newnet,Test);
 names = Test.Labels;
 pred = (predict==names);
 s = size(pred);
 acc = sum(pred)/s(1);
 fprintf('The accuracy of the test set is %f \n',acc*100);
 fprintf('Program paused. Please enter the path of you image and Press enter to continue.\n');
 pause;
 %% =============== Part 4: Testing on your own Image ================
 nameofs01 = 'Mirror Cube';
 nameofs02 = '3*3 Rubiks Cube';
 nameofs03 = '4*4 Rubiks Cube';
 
 % Please enter the path of you image below
 img = imread('img.jpg');
 img = imresize(img,[227 227]);
 predict = classify(newnet,img);
 if predict=='1'
    fprintf('The image detected is %s \n',nameofs01);
 elseif  predict=='2'
    fprintf('The image detected is %s \n',nameofs02);
 elseif  predict=='3'
    fprintf('The image detected is %s \n',nameofs03);
 end
 
 
 
 
 
