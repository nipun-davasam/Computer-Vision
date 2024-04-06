function A = estimateTransform(pts1i,pts2i,k)
%{
ESTIMATETRANSFORM Estimate transformation matrix using Direct Linear Transformation (DLT).
A = ESTIMATETRANSFORM(pts1i, pts2i, k) computes the transformation matrix A
using Direct Linear Transformation (DLT) algorithm given correspondences
between k pairs of points pts1i and pts2i.

pts1i: An k-by-2 matrix representing the coordinates of points in the 
     first image.
pts2i: An k-by-2 matrix representing the coordinates of points in the 
     second image.
k:     The number of correspondences between points in the two images.

A:     A 3-by-3 transformation matrix estimated using DLT algorithm.

The function constructs a design matrix P based on given correspondences,
performs Singular Value Decomposition (SVD) on P to obtain the solution
vector, and then reshapes it into a 3-by-3 matrix representing the
estimated transformation matrix A.
%}

% Set up design matrix P: size = 2*size(pts1i,1) x 9
P=zeros(2*k,9); % initialization 
for i = 1:k
    P(2*i-1,:)=[-pts1i(i,1), -pts1i(i,2), -1, 0, 0, 0, pts2i(i,1)*pts1i(i,1), pts2i(i,1)*pts1i(i,2), pts2i(i,1)];
    P(2*i,:)=[0, 0, 0, -pts1i(i,1), -pts1i(i,2), -1, pts2i(i,2)*pts1i(i,1), pts2i(i,2)*pts1i(i,2), pts2i(i,2)];
    
end

if size(P,1) == 8
    [U,S,V] = svd(P);
else
    [U,S,V] = svd(P,'econ');
end

q = V(:,end);

A=reshape(q,3,3); % homography matrix generation
A=A';

end