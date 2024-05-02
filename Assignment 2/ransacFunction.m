function M=ransacFunction(im1_points,im2_points,t)

Nransac = 10000;
t = 2;
n = size(im1_points,1);
k = 4;

nbest = 0;
% Abest = [];
idxbest = [];

for i_ransac = 1:Nransac
    
    % randomly sample set of indices to compute A
    idx = randperm( n,k );
    % rng('default');
    pts1i = im1_points(idx,:);
    pts2i = im2_points(idx,:);
     
    A_test = estimateTransform( pts1i,pts2i,k );

    pts2e = A_test * [im1_points';ones(1,n)];
    
    pts2e = pts2e(1:2,:) ./ pts2e(3,:);
    pts2e = pts2e';
    
    d = sqrt((pts2e(:,1)-im2_points(:,1)).^2 + (pts2e(:,2)-im2_points(:,2)).^2);
    
    idxgood = d < t;
    ngood = sum(idxgood);
    %Agood = A_test;

    if ngood > nbest
        nbest = ngood;
        %Abest = Agood;
        idxbest = idxgood;
    end
end

pts1inliers = im1_points(idxbest,:);
pts2inliers = im2_points(idxbest,:);

B = estimateTransform( pts1inliers, pts2inliers,k );
M=inv(B);