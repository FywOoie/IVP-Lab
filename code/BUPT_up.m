%This function is to up-sample the given image by two-directional factors
%by using either nearest or bilinear interploating way.

function upSampledImage = BUPT_up(M,interpolateWay,hFactor,vFactor)
    % M - input matrix, should be a gray or a 3-channel image
    %interploateWay - the way of interploating, should be either nearest or
    %bilinear
    %hFactor,vFactor - horizental and vertical scaling factor of the image
    %upSampledImage - output image matrix which is upsampled.
    
    [width,height,level] = size(M);
    %check for level of the input matrix
    if(level ~= 1 && level ~= 3)
        error('You should pass a gray or 3-channel image to this function!');
    end
    
    %upsample the image by given way
    if(strcmp(interpolateWay,'nearest') || strcmp(interpolateWay,'bilinear'))
        upSampledImage = imresize(M,[width*hFactor,height*vFactor],interpolateWay);
    else
        error('You should give the way of interploating as bilinear or nearest');
    end
end

