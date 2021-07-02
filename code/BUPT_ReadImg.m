%This funtion takes fileName of a ppm or a pgm file and return related values.

function [img,magicNum,width,height,maxValue,comment] = BUPT_ReadImg(fileName)

%input parameters: file name of the image to be read
%ouput parameters: 
%img          -   matrix which contains pixel values
%magicNum     -   magic header
%width,height -   size of the image
%max          -   max pixel value in the image
%comment      -  comment in the file

%open file in read mode
f = fopen(fileName,'r+');

%read image with imread function
img = imread(fileName);
img = double(img);

%get ppm or pgm header information
commentCount=0;%count comment numbers in the file
temp=fgetl(f);
if(contains(temp,'#'))
    commentCount=commentCount+1;
    comment{commentCount}=temp;%comment
    temp=fgetl(f);
end
magicNum=temp;%magic number

temp=fgetl(f);
if(contains(temp, '#'))
    commentCount = commentCount+1;
    comment{commentCount }= temp;%comment
    temp = fgetl(f);
end
sizeLine = temp;
picSize = regexp(sizeLine, ' ', 'split');
width = str2double(cell2mat(picSize(1)));%width
height = str2double(cell2mat(picSize(2)));%height

temp = fgetl(f);
if(contains(temp, '#'))
    commentCount = commentCount+1;
    comment{commentCount} = temp;%comment
    temp = fgetl(f);
end
maxValue = str2double(temp);%max pixel value

%handle errors
if(maxValue<0 || maxValue>255)
    error('header went wrong! The max value is out of scope!');
elseif(width<0 || height<0)
    error('header went wrong! The width or height value is out of scope!');
elseif(~strcmp(magicNum,'P2') && ~strcmp(magicNum,'P3') && ~strcmp(magicNum,'P5') && ~strcmp(magicNum,'P6'))
    error('It is not a pgm or ppm pic!');
end
