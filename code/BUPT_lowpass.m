%This function is to convolve the input image with a guassian kernel

function filteredImage = BUPT_lowpass(M,kernelSize,sigma)
%M - input matrix
%kernelSize - gussian kernel size
%sigma - standard variance of the gussian filtering
%filteredImgae - image which is filtered

%convolve the kernel with input image
kernel = fspecial('gaussian',[kernelSize,kernelSize],sigma);%define a kernel to be convolved
filteredImage = imfilter(uint8(M),kernel,'conv','symmetric');%filter by gussian

end

