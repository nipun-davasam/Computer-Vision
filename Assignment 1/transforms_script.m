clear all; close all; clc;

 % reading input image and normalising it followed by grayscaling image 
inputImage=imread('Image1.png');
inputDouble = im2double(inputImage);
grayImage = rgb2gray(inputDouble);
[h,w] = size(grayImage);

target_width = 1920;
target_height = 1080;

Sx = target_width / w;
Sy = target_height / h;

% matrices for transformations
scalingMatrix=[Sx 0 0;0 Sy 0;0 0 1];
rotationMatrix=[cosd(30),-sind(30),0;sind(30),cosd(30),0;0 0 1];
reflectionMatrix=[1 0 0; 0 -1 0; 0 0 1];
shearMatrix=[1 0.5 0;0 1 0;0 0 1];
affineMatrix1=[1 0.4 0.4;0.1 1 0.3;0 0 1];
affineMatrix2=[2.1 -0.35 -0.1;-0.3 0.7 0.3;0 0 1];
homographyMatrix1=[0.8 0.2 0.3;-0.1 0.9 -0.1;0.0005 -0.0005 1];
homographyMatrix2=[29.25 13.95 20.25;4.95 35.55 9.45;0.045 0.09 45];

%matrices for 5th part of question
A1=[1 0 300;0 1 500;0 0 1];
A2=[cosd(-20),-sind(-20),0;sind(-20),cosd(-20),0;0 0 1];
A3=[0.5 0 0;0 0.5 0;0 0 1];
compositeMatrix={A3,A2,A1};


%Output of images after transformations
outputImageOfScaling=transformImage(inputImage,scalingMatrix,'scaling');
outputImageOfReflection=transformImage(inputImage,reflectionMatrix,'reflection');
outputImageOfRotation=transformImage(inputImage,rotationMatrix,'rotation');
outputImageOfShear=transformImage(inputImage,shearMatrix,'shear');
outputImageOfAffine1=transformImage(inputImage,affineMatrix1,'affine');
outputImageOfAffine2=transformImage(inputImage,affineMatrix2,'affine');
outputImageOfHomography1=transformImage(inputImage,homographyMatrix1,'homography');
outputImageOfHomography2=transformImage(inputImage,homographyMatrix2,'homography');
outputImageOfCompositeOperations=transformImage(inputImage,compositeMatrix,'composite');

%plotting of output images
figure;imshow(grayImage);title('Input Image in Gray Scale');
figure;imshow(outputImageOfScaling);title('Output Image 1');
figure;imshow(outputImageOfReflection);title('Output Image 2');
figure;imshow(outputImageOfRotation);title('Output Image 3');
figure;imshow(outputImageOfShear);title('Output Image 4');
figure;imshow(outputImageOfCompositeOperations);title('Output Image 5');
figure;imshow(outputImageOfAffine1);title('Output Image 6.1');
figure;imshow(outputImageOfAffine2);title('Output Image 6.2');
figure;imshow(outputImageOfHomography1);title('Output Image 7.1');
figure;imshow(outputImageOfHomography2);title('Output Image 7.2');
