%This function is to detect edges of an image by using three types of
%filters.

function edgedImage = BUPT_edge(M,filterType)
%M - input image matrix
%filterType - filter type, can be sobel, roberts or prewitt
%edgedImage - output image with edges

if(strcmp(filterType,'sobel'))%sobel filter
    dx=[ 1 0 -1; 2 0 -2; 1 0 -1];
    dy=[ -1 -2 -1; 0 0 0; 1 2 1];
elseif(strcmp(filterType,'roberts'))%roberts filter
    dx=[ 0 0 -1; 0 1 0; 0 0 0];
    dy=[ -1 0 0; 0 1 0; 0 0 0];
elseif(strcmp(filterType,'prewitt'))%prewitt filter
    dx=[ 1 0 -1; 1 0 -1; 1 0 -1];
    dy=[ -1 -1 -1; 0 0 0; 1 1 1];
else
    error('You should enter sobel, roberts or prewitt as the second parameter');
end

edgeX = double(imfilter(uint8(M),dx,'symmetric'));%filter in x direction
edgeY = double(imfilter(uint8(M),dy,'symmetric'));%filter in y direction
edgedImage = ((edgeX.*edgeX)+(edgeY.*edgeY)).^0.5;%merge two directions

end

