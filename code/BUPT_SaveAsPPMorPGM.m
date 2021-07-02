%This function is to save the input matrix to the specified file in either
%ascii or bianry mode

function [] = BUPT_SaveAsPPMorPGM(M,outFileName,mode)
% M            -   input image matrix
% outFileName  -   output file location
% mode         -   0 for BINARY 1; forASCII

%  magicNum  suffix     encoding
%     P2      .pgm       ASCII   
%     P3      .ppm       ASCII      
%     P5      .pgm       Binary   
%     P6      .ppm       Binary 

[width,height,level] = size(M);%get the dimension of input M
%handle errors
if(level~=1 && level~=3)
    error('You should give a gray image or a rgb image!');
elseif(mode~=0 && mode~=1)
    error('Please enter 0-bianry mode or 1-ascii mode as the third parameter!');
end
    
f = fopen(outFileName,'w');%open file in write mode

if((mode==1) && (level==1))%P2
    fprintf(f,'P2\n'); %write magic header
    fprintf(f,'# image created by Yibo Lian\n');%write comment
    %write width and height
    fprintf(f,'%i ',width);
    fprintf(f,'%i\n',height);
    %write max
    maxValue = max(max(M));%get max value of the matrix
    fprintf(f,'%i\n',floor(maxValue));
    
    for i=1:width
        for j=1:height
            fprintf(f,'%s ',num2str(M(i,j)));
        end
        fprintf(f,'\n');%switch new line after writing a line
    end
    
elseif((mode==1) && (level==3))%P3
    fprintf(f,'P3\n'); %write magic header
    fprintf(f,'# image created by Yibo Lian\n');%write comment
    %write width and height
    fprintf(f,'%i ',width);
    fprintf(f,'%i\n',height);
    %write max
    fprintf(f,'%i\n',255);
    
    for i=1:width
        for j=1:height
            fprintf(f,'%s ',num2str(M(i,j,1)));%R
            fprintf(f,'%s ',num2str(M(i,j,2)));%G
            fprintf(f,'%s ',num2str(M(i,j,3)));%B
        end
        fprintf(f,'\n');%switch new line after writing a line
    end
    
elseif((mode==0) && (level==1))%P5
    fprintf(f,'P5\n'); %write magic header
    fprintf(f,'# image created by Yibo Lian\n');%write comment
    %write width and height
    fprintf(f,'%i ',width);
    fprintf(f,'%i\n',height);
    %write max
    maxValue = max(max(M));%get max value of the matrix
    fprintf(f,'%i\n',floor(maxValue));
    
    for i=1:width
        for j=1:height
            fwrite(f,M(i,j),'uint8');
        end
    end
    
elseif((mode==0) && (level==3))%P6
    fprintf(f,'P6\n'); %write magic header
    fprintf(f,'# image created by Yibo Lian\n');%write comment
    %write width and height
    fprintf(f,'%i ',width);
    fprintf(f,'%i\n',height);
    %write max
    fprintf(f,'%i\n',255);
    
    for i=1:width
        for j=1:height
            fwrite(f,M(i,j,1),'uint8'); %R
            fwrite(f,M(i,j,2),'uint8'); %G
            fwrite(f,M(i,j,3),'uint8'); %B
        end
    end
else
    error('You should pass in mode as an 0 or 1');
end
    
fclose(f);%close the file
end
