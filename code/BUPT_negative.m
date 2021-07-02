%This function is to transform images to negative images

function negativeImg = BUPT_negative(inFile)

%inFile - input file name of the image to be transformed negative
%negativeImg - output negative image

positiveImg = imread(inFile);%read grayscale positive image
[~,~,level] = size(positiveImg);%get level of the image

imInfor = imfinfo(inFile);%get information of the image
bitDepth = imInfor.BitDepth;%get bit depth of the image
if(level==1)
    scale = 2^bitDepth - 1;%get grayscales of the image
elseif(level==3)
    scale = 2^(bitDepth/3) - 1;%get color intensity max value
end

negativeImg = scale - positiveImg;%calculate the negative image intensities

end

