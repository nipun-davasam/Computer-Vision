    function TransformedImage = transformImage(InputImage,TransformMatrix,TransformType)   
%{
    transformImage - Transform a grayscale image according to the given transformation.

    Syntax:
        TransformedImage = transformImage(InputImage, TransformMatrix, TransformType)

    Description:
        transformImage method applies a transformation to a grayscale image based on the given transformation matrix and type.

    Inputs:
        InputImage - The grayscale input image.
        TransformMatrix - The transformation matrix defining the transformation to be applied.
        TransformType - The type of transformation. It can be one of the following: 'scaling', 'rotation', 'translation', 'reflection', 'shear', 'affine', or 'homography'.

    Outputs:
        TransformedImage - The transformed image.

    Example:
        % Apply a scaling transformation to the input image
        InputImage = imread('input.png');
        TransformMatrix = [2, 0, 0; 0, 2, 0; 0, 0, 1]; % Example scaling matrix
        TransformType = 'scaling';
        TransformedImage = transformImage(InputImage, TransformMatrix, TransformType);
%}

    
    % switch case to pick the right matrix depending on TransformType
    switch lower(TransformType)
        case 'homography'
            A=TransformMatrix;
            Ainv=inv(A);
        case 'affine'
            A=TransformMatrix;
            Ainv=inv(A);
        case 'scaling'
            A=TransformMatrix;
            Ainv=A;
            Ainv(1,1)=1/Ainv(1,1);
            Ainv(2,2)=1/Ainv(2,2);                   
        case 'rotation'
            A=TransformMatrix;
            Ainv=A;
            Ainv(2)=-Ainv(2);
            Ainv(4)=-Ainv(4);            
        case 'reflection'
            A=TransformMatrix;
            Ainv=A.*(-1);
        case 'shear'
            A=TransformMatrix;
            Ainv=A;
            Ainv(1,2) = -Ainv(1,2);
        case 'composite'
            A3=TransformMatrix{1};
            A2=TransformMatrix{2};
            A1=TransformMatrix{3};
            A=A3*A2*A1;
            % inverse of translation matrix A1
            A1inv=A1;
            A1inv(1,3)=-A1inv(1,3);
            A1inv(2,3)=-A1inv(2,3);
            % inverse of rotation matrix A2           
            A2inv=A2;
            A2inv(2)=-A2inv(2);
            A2inv(4)=-A2inv(4); 
            % inverse of scaling matrix A3
            A3inv=A3;
            A3inv(1,1)=1/A3inv(1,1);
            A3inv(2,2)=1/A3inv(2,2);   
            Ainv=A1inv*A2inv*A3inv;  
            % Ainv=inv(A);
    end
    
    % reading input image and normalising it followed by grayscaling image 
    inputDouble = im2double(InputImage);
    grayImage = rgb2gray(inputDouble);
    [h,w] = size(grayImage);
    
    % cordinates of input image frame
    a = [1,1];
    b = [w,1];
    c = [1,h];
    d = [w,h];
    
	 % finding new cordinates for transformed image via TransformMatrix
    cornersprime = A*[a',b',c',d';1, 1, 1, 1];

     % 1/what is applied to all homogeneous coordinates
    cornersprime = [cornersprime(1,:)./cornersprime(3,:);cornersprime(2,:)./cornersprime(3,:)];
    
    cornersprime = ceil(cornersprime); % taking only whole numbers
    
    
	% bounding box dimensions
    minx = 1;
    miny = 1;
    
    maxx = max(cornersprime(1,:));
    maxy = max(cornersprime(2,:));
    
    wprime = maxx - minx + 1;
    hprime = maxy - miny + 1;
    
    [Xprime,Yprime] = meshgrid( minx:maxx, miny:maxy );
    pprime = [Xprime(:)';Yprime(:)';ones(1,numel(Xprime))];
   

    phat = Ainv * pprime;
    xhat = phat(1,:);
    yhat = phat(2,:);
    what = phat(3,:);
    
    x = xhat ./ what;
    y = yhat ./ what;
    
    x = reshape( x', hprime, wprime );
    y = reshape( y', hprime, wprime );
    
    % output image
    TransformedImage = interp2( grayImage, x, y );

end






