%This function is to transform input image to an edged image

function edgedImage = BUPT_LoG(M,kernelSize,sigma)
%M - input image matrix
%sigma - standard variance of gussian operator
%edgedImage - output logical edged image

%check for level of the image
[height,width,level] = size(M);
if(level == 3)
    %convert to grayscale image for edge function can only take in 2D matrix
    M = rgb2gray(uint8(M));
elseif(level ~= 1)
    error('You should pass in a 3-channel or grayscale image to this function');
end

%logKernel = fspecial('log',kernelSize,sigma);
%edgedImage = imfilter(uint8(M),logKernel,'conv','symmetric');

kernel = [kernelSize, kernelSize];

%Gaussian filter
r = (kernel-1)/2;
std = sqrt(sigma);
[x,y] = meshgrid(-r(2):r(2),-r(1):r(1));
gaussianF = -1/(pi*(std^4))*(1-(x.*x+y.*y)/(2*std^2)).*exp(-(x.*x+y.*y)/(2*std^2));

%filter
newM = filter2(gaussianF,M);

edgedImage = zeros(height,width);
T = 0.75 * mean2(abs(newM(2:height-1,2:width-1)));
%change pixel values
for i = 2 : height-1
    for j = 2 : width-1
        if (newM(i,j)<0)
            if (newM(i+1,j)>0 || newM(i,j+1)>0 || newM(i,j-1)>0 || newM(i-1,j) > 0)
                if (max([newM(i+1,j) newM(i,j+1) newM(i,j-1) newM(i-1,j)])-newM(i,j) > T)
                    edgedImage(i,j)=1;
                end
            end
        else if(newM(i,j)==0)
                if (newM(i+1,j)*newM(i-1,j)<0&&abs(newM(i+1,j)-newM(i-1,j))>2*T)||(newM(i,j+1)*newM(i,j-1)<0&&abs(newM(i,j+1)-newM(i,j-1))>2*T)
                    edgedImage(i,j)=1;
                end
            end
        end
    end
end

% thresholding
edgedImage = edgedImage * 255;

end

