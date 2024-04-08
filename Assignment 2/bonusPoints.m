clear all; close all; clc;


% converting images to gray scale and fitting to range 0-255 values
left=imread('Input Images/im1.jpg');
middle=imread('Input Images/im2.jpg');
right=imread('Input Images/im3.jpg');
inputDouble1 = im2double(left);
inputDouble2 = im2double(middle);
inputDouble3 = im2double(right);
grayImageLeft = rgb2gray(inputDouble1);
grayImageMiddle = rgb2gray(inputDouble2);
grayImageRight = rgb2gray(inputDouble3);


% taking feature points from left and middle images

points1 = detectSURFFeatures(grayImageLeft);
points2 = detectSURFFeatures(grayImageMiddle);

features1 = extractFeatures(grayImageLeft,points1);
features2 = extractFeatures(grayImageMiddle,points2 );

% extracting significant and overlapping features from the image
indexPairs = matchFeatures(features1,features2, 'Unique', true );

matchedPoints1 = points1(indexPairs( :,1));
matchedPoints2 = points2(indexPairs( :,2));
im1_points = matchedPoints1.Location;
im2_points = matchedPoints2.Location;

figure;
% rendering only first 20 feature points for ease of visualising 
showMatchedFeatures(grayImageLeft, grayImageMiddle, im1_points(1:20,:), im2_points(1:20,:), "montage")
legend("Matched points 1","Matched points 2");


%% taking feature points from middle and right images

% points3 = detectSURFFeatures(grayImageMiddle);
% points4 = detectSURFFeatures(grayImageRight);
% 
% features1 = extractFeatures(grayImageMiddle,points3);
% features2 = extractFeatures(grayImageRight,points4 );
% 
% % extracting significant and overlapping features from the image
% indexPairs = matchFeatures(features1,features2, 'Unique', true );
% 
% matchedpoints3 = points3(indexPairs( :,1));
% matchedpoints4 = points4(indexPairs( :,2));
% im3_points = matchedpoints3.Location;
% im4_points = matchedpoints4.Location;
% 
% figure;
% % rendering only first 20 feature points for ease of visualising 
% showMatchedFeatures(grayImageMiddle, grayImageRight, im3_points(1:20,:), im4_points(1:20,:), "montage")
% legend("Matched points 3","Matched points 4");


%% Code for transformations
threshold1=1;
M1=ransacFunction(im1_points,im2_points,threshold1);
im2_transformed=transformImage(left,M1,'homography');
nanlocations = isnan( im2_transformed );
im2_transformed( nanlocations )=0;
figure;
imshow(im2_transformed);title("Transformed Image2/left");
% title('Transformed Right Image');


% Part 5: expanding image to match im2_transformed
[h1,w1]=size(grayImageMiddle);
[h2,w2]=size(im2_transformed);
h_diff=abs(h2-h1);
w_diff=abs(w2-w1);
% zero padding to match the transformed image size 
if h2<=h1
    im1_expanded = imresize(grayImageMiddle,[h2,w2]);
else
    im1_expanded = padarray(grayImageMiddle,[h_diff w_diff],0,'post');
end

figure;
imshow(im1_expanded);title("Expanded Image1/middle");

[x_overlap_1,y_overlap_1]=ginput(2);
overlap_left_1=round(x_overlap_1(1));
overlap_right_1=round(x_overlap_1(2));
step_value_1 = 1 / (overlap_right_1 - overlap_left_1);
ramp_middle=[ones(1,overlap_left_1),1:-step_value_1:0,zeros(1,size(im2_transformed,2) - overlap_right_1-1)];
% taking inverse to get the ramp for the right image pixels 
ramp_left=abs(1-ramp_middle); 

figure; plot(ramp_middle);title('Ramp for middle Image')
figure; plot(ramp_left);title('Ramp for Left Image')

%%
im_middle_blend=im1_expanded.*repmat(ramp_middle,h2,1);
im_left_blend=im2_transformed.*repmat(ramp_left,size(im2_transformed,1),1);
figure;imshow(im_middle_blend);title("Middle Blended");
figure;imshow(im_left_blend);title("Left Blended");

% Part 6
% panaroma after blending left and right images 
impanorama=im_middle_blend+im_left_blend;
figure;
imshow(impanorama);title("Panaroma");

