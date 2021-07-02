%This function convert input RGB color ppm image to YUV color model and
%save only Y component to file to serve as a converter to grayscale image

function yuv = BUPT_format_converter(inFile,outFile,saveAs)

%input parameters:
%inFile     - the RGB format color ppm image file to be read
%outFile    - the grayscale format pgm image file to be written,
%only be used when saveOrNot = 1
%saveAs     - 1 if the user only wants to convert it to grayscale, 2 if the 
%user wants to save it as color image, others if user don't want to save it

%output parameters:
%model:yuv color model image matrix

    [img,magicNum,width,height,~,~] = BUPT_ReadImg(inFile);%read ppm file
    [~,~,level] = size(img);%size of the read image
    %handle errors
    if(level~=3)%the third dimension should be 3
        error('input image file should be a rgb image!');
    end
    if(strcmp(magicNum,'P3'))%magic identifier should be either P3 or P6
        mode = 1;%if ascii format is read, it should be written in ascii
    elseif(strcmp(magicNum,'P6'))
        mode = 0;%if binary format is read, it should be written in binary
    else
        error('Magic identifier error!');
    end
    
    
    %Preallocated memory to y u v for they are in iteration
    y = zeros(width,height);
    u = zeros(width,height);
    v = zeros(width,height);
    for i=1:width
        for j=1:height
            %extract color components
            r = img(i,j,1);
            g = img(i,j,2);
            b = img(i,j,3);
                
            y(i,j) = 0.257 * r + 0.504 * g + 0.098 * b + 16;
            u(i,j) = -0.148 * r - 0.291 * g + 0.439 * b + 128;
            v(i,j) = 0.439 * r - 0.368 * g - 0.071 * b + 128;
        end
    end
    yuv = cat(3,y,u,v);
    
    %if user want to save it to file, call save function defined earlier
    if(saveAs == 1)
        BUPT_SaveAsPPMorPGM(floor(y),outFile,mode);
    elseif(saveAs == 2)
        BUPT_SaveAsPPMorPGM(floor(yuv),outFile,mode);
    end
    
end

