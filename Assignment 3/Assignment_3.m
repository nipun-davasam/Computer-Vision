clc; close all; clear all;


%% Part 1.1
inputImage=imread("Lego_object.jpg");
[impoints,objpoints3D]=clickPoints(inputImage,'dalekosaur');
%
% plotting image point and object points 
figure; title('Image 2D points');
imshow(inputImage); hold on;
plot(impoints(:,1),impoints(:,2),'b.');

load('dalekosaur/object.mat');
%%
figure; title('Object 3D points');
patch('vertices',Xo','faces',Faces,'facecolor','w','edgecolor','y');
axis vis3d;
axis equal;
hold on;
plot3(objpoints3D(:,1),objpoints3D(:,2),objpoints3D(:,3),'b*');
xlabel('Xo-axis'); ylabel('Yo-axis'); zlabel('Zo-axis');

%% part 1.2
M=estimateCameraProjection(impoints,objpoints3D);

%% part 1.3
A=M(:,1:3);
C=A * A';
lambda = 1/sqrt(C(3,3));
xc=power(lambda,2)*C(1,3);
yc=power(lambda,2)*C(2,3);
fy=abs(sqrt(power(lambda,2)*C(2,2)-power(yc,2)));
alpha=(1/fy)*(power(lambda,2)*C(1,2)-(xc*yc));
fx=abs(sqrt(power(lambda,2)*C(1,1)-power(alpha,2)-power(xc,2)));

K=[fx,alpha,xc;0,fy,yc;0,0,1]; 
R=(lambda.*inv(K))*A;
if det(R) ~= 1
    R= -R;
    lambda= -lambda;
end
b = M(:,4);
t = (lambda.*inv(K))*b;

%% part 1.4

imgpoints2D_estimate=K*[R t]*[objpoints3D';ones(1,length(objpoints3D))];
imgpoints2D_estimate=imgpoints2D_estimate(1:2,:)./imgpoints2D_estimate(3,:);

figure;
imshow(inputImage); hold on;
x=K*[R t]*[Xo;ones(1,length(Xo))];
x=x(1:2,:)./x(3,:); % normalising 
patch( 'vertices', x', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
plot( impoints(:,1)', impoints(:,2)', 'b.') ;
plot( imgpoints2D_estimate(1,:), imgpoints2D_estimate(2,:), 'ro' );
hold off;
saveas(gcf, 'Pics/superposed_mesh_image.png');
error_sum_square = sum((impoints-imgpoints2D_estimate').^2);
save('camera_lego_data.mat', 'impoints', 'objpoints3D', 'M', 'K', 'R', 't', 'imgpoints2D_estimate', 'error_sum_square');


%%
% Part2
load('calibrationSession.mat');
cameraParams = calibrationSession.CameraParameters;
K_checker=cameraParams.K;


%% Part3 
% Surface 1
surface1 = imread("Pics/Surface1.jpg");

% Orientation 1
Rp = rotationMatrix(10, 50, 0);
close all;
tp = translationMatrix(7, 5, -30);
% Using K
figure;

X_transformed_1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_1 = K*X_transformed_1;
x_projected_1 = x_projected_1(1:2, :)./x_projected_1(3, :);

pointsInFront_1=isinfront(X_transformed_1,Faces); % TAKES A LONG TIME TO RUN

imshow(surface1); hold on;

lightdirectionvector_1=[-2,8,-12];
displayLit(x_projected_1,X_transformed_1,Faces,lightdirectionvector_1,pointsInFront_1);
title('Surface 1 using K camera parameters and Orientation 1');
saveas(gcf, 'Pics/Surface 1 using K camera parameters and Orientation 1.png');
hold off;



% Using K_checker
figure;
x_projected_12 = K_checker*X_transformed_1;
x_projected_12 = x_projected_12(1:2, :)./x_projected_12(3, :);

pointsInFront_12=isinfront(X_transformed_1,Faces); % TAKES A LONG TIME TO RUN
imshow(surface1); hold on;


displayLit(x_projected_12,X_transformed_1,Faces,lightdirectionvector_1,pointsInFront_12);
title('Surface 1 using K-checker camera parameters and Orientation 1');
saveas(gcf, 'Pics/Surface 1 using K-checker camera parameters and Orientation 1.png');
hold off;


% Orientation 2
Rp = rotationMatrix(10, -60, 0);
close all;
tp = translationMatrix(17, 7, -70);
% Using K
figure;

X_transformed_2 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_2 = K*X_transformed_2;
x_projected_2 = x_projected_2(1:2, :)./x_projected_2(3, :);

pointsInFront_2=isinfront(X_transformed_2,Faces); % TAKES A LONG TIME TO RUN

imshow(surface1); hold on;

lightdirectionvector_2=[-2,-8,-12];
displayLit(x_projected_2,X_transformed_2,Faces,lightdirectionvector_2,pointsInFront_2);
title('Surface 1 using K camera parameters and Orientation 2');
% patch( 'vertices', x_projected_2', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
saveas(gcf, 'Pics/Surface 1 using K camera parameters and Orientation 2.png');
hold off;

% Using K_checker
figure;
x_projected_22 = K_checker*X_transformed_2;
x_projected_22 = x_projected_22(1:2, :)./x_projected_22(3, :);

pointsInFront_22=isinfront(X_transformed_2,Faces); % TAKES A LONG TIME TO RUN
imshow(surface1); hold on;


displayLit(x_projected_22,X_transformed_2,Faces,lightdirectionvector_2,pointsInFront_22);
title('Surface 1 using K-checker camera parameters and Orientation 2');
saveas(gcf, 'Pics/Surface 1 using K-checker camera parameters and Orientation 2.png');
hold off;

% Orientation 3
Rp = rotationMatrix(10, -130, 0);
close all;
tp = translationMatrix(13, 7, -50);
% Using K
figure;

X_transformed_3 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_3 = K*X_transformed_3;
x_projected_3 = x_projected_3(1:2, :)./x_projected_3(3, :);

pointsInFront_3=isinfront(X_transformed_3,Faces); % TAKES A LONG TIME TO RUN

imshow(surface1); hold on;

lightdirectionvector_3=[-20,-8,-12];
displayLit(x_projected_3,X_transformed_3,Faces,lightdirectionvector_3,pointsInFront_3);
title('Surface 1 using K camera parameters and Orientation 3');
% patch( 'vertices', x_projected_3', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
saveas(gcf, 'Pics/Surface 1 using K camera parameters and Orientation 3.png');
hold off;



% Using K_checker
figure;
x_projected_32 = K_checker*X_transformed_3;
x_projected_32 = x_projected_32(1:2, :)./x_projected_32(3, :);

pointsInFront_32=isinfront(X_transformed_3,Faces); % TAKES A LONG TIME TO RUN
imshow(surface1); hold on;


displayLit(x_projected_32,X_transformed_3,Faces,lightdirectionvector_3,pointsInFront_32);
title('Surface 1 using K-checker camera parameters and Orientation 3');
saveas(gcf, 'Pics/Surface 1 using K-checker camera parameters and Orientation 3.png');
hold off;


% Surface 2
surface2 = imread("Pics/Surface4.jpg");

% Orientation 1
close all;
Rp = rotationMatrix(27 , -70, 0);
tp = translationMatrix(30, 18, -60);


% Using K
figure;

X_transformed_21 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_21 = K*X_transformed_21;
x_projected_21 = x_projected_21(1:2, :)./x_projected_21(3, :);

pointsInFront_21=isinfront(X_transformed_21,Faces); % TAKES A LONG TIME TO RUN

imshow(surface2); hold on;

lightdirectionvector_21=[-8,-8,-5];
displayLit(x_projected_21,X_transformed_21,Faces,lightdirectionvector_21,pointsInFront_21);
title('Surface 2 using K camera parameters and Orientation 1');
% patch( 'vertices', x_projected_21', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
saveas(gcf, 'Pics/Surface 2 using K camera parameters and Orientation 1.png');
hold off;


% Using K_checker
figure;
x_projected_212 = K_checker*X_transformed_21;
x_projected_212 = x_projected_212(1:2, :)./x_projected_212(3, :);

pointsInFront_212=isinfront(X_transformed_21,Faces); % TAKES A LONG TIME TO RUN
imshow(surface2); hold on;

displayLit(x_projected_212,X_transformed_21,Faces,lightdirectionvector_21,pointsInFront_212);
title('Surface 2 using K-checker camera parameters and Orientation 1');
saveas(gcf, 'Pics/Surface 2 using K-checker camera parameters and Orientation 1.png');
hold off;

%
% Orientation 2
close all;
Rp = rotationMatrix(27 , -140, 0);
tp = translationMatrix(30, 18, -60);

% Using K
figure;

X_transformed_22 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_22 = K*X_transformed_22;
x_projected_22 = x_projected_22(1:2, :)./x_projected_22(3, :);

pointsInFront_22=isinfront(X_transformed_22,Faces); % TAKES A LONG TIME TO RUN

imshow(surface2); hold on;

lightdirectionvector_22=[-2,8,-12];
displayLit(x_projected_22,X_transformed_22,Faces,lightdirectionvector_22,pointsInFront_22);
title('Surface 2 using K camera parameters and Orientation 2');
% patch( 'vertices', x_projected_22', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
saveas(gcf, 'Pics/Surface 2 using K camera parameters and Orientation 2.png');
hold off;

% Using K_checker
figure;
x_projected_222 = K_checker*X_transformed_22;
x_projected_222 = x_projected_222(1:2, :)./x_projected_222(3, :);

pointsInFront_222=isinfront(X_transformed_22,Faces); % TAKES A LONG TIME TO RUN
imshow(surface2); hold on;


displayLit(x_projected_222,X_transformed_22,Faces,lightdirectionvector_22,pointsInFront_222);
title('Surface 2 using K-checker camera parameters and Orientation 2');
saveas(gcf, 'Pics/Surface 2 using K-checker camera parameters and Orientation 2.png');
hold off;
%


% Orientation 3
close all;
Rp = rotationMatrix(27 , -90, 0);
tp = translationMatrix(33, 16, -60);

% Using K
figure;
X_transformed_23 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected_23 = K*X_transformed_23;
x_projected_23 = x_projected_23(1:2, :)./x_projected_23(3, :);

pointsInFront_23=isinfront(X_transformed_23,Faces); % TAKES A LONG TIME TO RUN

imshow(surface2); hold on;

lightdirectionvector_23=[-20,-8,-12];
displayLit(x_projected_23,X_transformed_23,Faces,lightdirectionvector_23,pointsInFront_23);
title('Surface 2 using K camera parameters and Orientation 3');
% patch( 'vertices', x_projected_23', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
saveas(gcf, 'Pics/Surface 2 using K camera parameters and Orientation 3.png');
hold off;

% Using K_checker
figure;
x_projected_232 = K_checker*X_transformed_23;
x_projected_232 = x_projected_232(1:2, :)./x_projected_232(3, :);

pointsInFront_32=isinfront(X_transformed_23,Faces); % TAKES A LONG TIME TO RUN
imshow(surface2); hold on;


displayLit(x_projected_232,X_transformed_23,Faces,lightdirectionvector_23,pointsInFront_32);
title('Surface 2 using K-checker camera parameters and Orientation 3');
saveas(gcf, 'Pics/Surface 2 using K-checker camera parameters and Orientation 3.png');
hold off;