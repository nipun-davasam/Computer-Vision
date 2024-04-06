clear all; close all; clc;

% Part 1

% converting images to gray scale and fitting to range 0-255 values
im1=imread('Input Images/Image1.jpg');
im2=imread('Input Images/Image2.jpg');
inputDouble1 = im2double(im1);
inputDouble2 = im2double(im2);
grayImage1 = rgb2gray(inputDouble1);
grayImage2 = rgb2gray(inputDouble2);


% Part 2
% extracting features from the image 
points1 = detectSURFFeatures(grayImage1);
points2 = detectSURFFeatures(grayImage2);

features1 = extractFeatures(grayImage1,points1);
features2 = extractFeatures(grayImage2,points2 );

% extracting significant and overlapping features from the image
indexPairs = matchFeatures(features1,features2, 'Unique', true );

matchedPoints1 = points1(indexPairs( :,1));
matchedPoints2 = points2(indexPairs( :,2));
im1_points = matchedPoints1.Location;
im2_points = matchedPoints2.Location;

figure;
% rendering only first 20 feature points for ease of visualising 
showMatchedFeatures(grayImage1, grayImage2, im1_points(1:20,:), im2_points(1:20,:), "montage")
legend("Matched points 1","Matched points 2");


%% Part 3
% Nransac = 10000;
% t = 2;
% n = size(im1_points,1);
% k = 4;
% 
% nbest = 0;
% % Abest = [];
% idxbest = [];
% 
% for i_ransac = 1:Nransac
% 
%     % randomly sample set of indices to compute A
%     idx = randperm( n,k );
%     % rng('default');
%     pts1i = im1_points(idx,:);
%     pts2i = im2_points(idx,:);
% 
%     A_test = estimateTransform( pts1i,pts2i,k );
% 
%     pts2e = A_test * [im1_points';ones(1,n)];
% 
%     pts2e = pts2e(1:2,:) ./ pts2e(3,:);
%     pts2e = pts2e';
% 
%     d = sqrt((pts2e(:,1)-im2_points(:,1)).^2 + (pts2e(:,2)-im2_points(:,2)).^2);
% 
%     idxgood = d < t;
%     ngood = sum(idxgood);
%     %Agood = A_test;
% 
%     if ngood > nbest
%         nbest = ngood;
%         %Abest = Agood;
%         idxbest = idxgood;
%     end
% end
% 
% pts1inliers = im1_points(idxbest,:);
% pts2inliers = im2_points(idxbest,:);
% 
% B = estimateTransform( pts1inliers, pts2inliers,k );
% B_inv=inv(B);
threshold=2;
M=ransacFunction(im1_points,im2_points,threshold);
%% Part 4
im2_transformed=transformImage(im2,M,'homography');
nanlocations = isnan( im2_transformed );
im2_transformed( nanlocations )=0;
figure;
imshow(im2_transformed);title("Transformed Image2");
title('Transformed Right Image');

% [x_overlap,y_overlap]=ginput(2);
% 
% 
% overlap_left=round(x_overlap(1));
% overlap_right=round(x_overlap(2));
% step_value = 1 / (overlap_right - overlap_left);
% ramp2=[zeros(1,overlap_left),0:step_value:1,ones(1,size(im2_transformed,2) - overlap_right-1)];
% figure; plot(ramp2);
% im2_blend=im2_transformed.*repmat(ramp2,size(im2_transformed,1),1);
% figure;imshow(im2_blend);


% Part 5: expanding image to match im2_transformed
[h1,w1]=size(grayImage1);
[h2,w2]=size(im2_transformed);
h_diff=abs(h2-h1);
w_diff=abs(w2-w1);
% zero padding to match the transformed image size 
im1_expanded = padarray(grayImage1,[h_diff w_diff],0,'post');
figure;
imshow(im1_expanded);title("Expanded Image1");

[x_overlap_1,y_overlap_1]=ginput(2);
overlap_left_1=round(x_overlap_1(1));
overlap_right_1=round(x_overlap_1(2));
step_value_1 = 1 / (overlap_right_1 - overlap_left_1);
ramp1=[ones(1,overlap_left_1),1:-step_value_1:0,zeros(1,size(im2_transformed,2) - overlap_right_1-1)];
% taking inverse to get the ramp for the right image pixels 
ramp2=abs(1-ramp1); 

figure; plot(ramp1);title('Ramp for Left/Image1')
figure; plot(ramp2);title('Ramp for Right/Image2')
im1_blend=im1_expanded.*repmat(ramp1,h2,1);
im2_blend=im2_transformed.*repmat(ramp2,size(im2_transformed,1),1);
figure;imshow(im1_blend);title("Image1 Blended");
figure;imshow(im2_blend);title("Image2 Blended");

% Part 6
% panaroma after blending left and right images 
impanorama=im1_blend+im2_blend;
figure;
imshow(impanorama);title("Panaroma");

%% Saving output images
imwrite(im2_transformed,"Output Images/Image2_Transformed.png"); % modify the output location for other set of input images
imwrite(im1_expanded,"Output Images/Image1_Expanded.png"); 
imwrite(im1_blend,"Output Images/Image1_blended.png");
imwrite(im2_blend,"Output Images/Image2_blended.png");
imwrite(impanorama,"Output Images/Panorama.png");




