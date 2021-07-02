%This function is to add noise to the image by guassian or salt and pepper
%noise.

function [noiseImage,MSE,PSNR] = BUPT_addNoise(I,noise,variance)

%I - input image matrix
%noise - category of the noise to be added, should be either guassian or
%salt and pepper noise
%variance - variance of the the noise

%check if it is a grayscale image
[width,height,level] = size(I);
if(level~=1)
    error('You should pass a grayscale image to this function!');
end

%add noise
if(strcmp(noise,'gaussian'))
    noiseImage = imnoise(uint8(I),noise,variance);%gaussian noise
elseif(strcmp(noise,'salt & pepper'))
    noiseImage = imnoise(uint8(I),noise);%salt and pepper noise
else
    error('You should enter gaussian or salt & pepper as the second parameter');
end

% Caculate the values of MSE and PSNR
delta = double(noiseImage) - double(I);
delta = delta.*delta;
MSE = sum(sum(delta))/(width*height);
PSNR = 20*log10(255/(MSE^0.5));

end
