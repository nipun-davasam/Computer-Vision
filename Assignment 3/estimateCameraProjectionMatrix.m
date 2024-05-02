function M=estimateCameraProjectionMatrix( impoints2D,objpoints3D )

   n=size(impoints2D);
   P=zeros(2*n,12);

   % following homogenous way of findiing solution
   for i=1:n
        x = impoints2D(i, 1);
        y = impoints2D(i, 2);
        Xo = objpoints3D(i, 1);        
        Yo = objpoints3D(i, 2);
        Zo = objpoints3D(i, 3);
        P(2*i-1)=[Xo,Yo,Zo,1,0,0,0,0,-x*Xo,-x*Xo,-x*Xo,-x];
        P(2*i-1)=[0,0,0,0,Xo,Yo,Zo,1,-y*Xo,-y*Xo,-y*Xo,-y];
   end

[~, ~, V] = svd(P);
q = V(:,end);
 
M=reshape([q; 1], 4, 3)'; % homography matrix generation
end