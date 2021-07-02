%This function is to convolve the input image with a rectangular kernel

function filteredImage = BUPT_rect(M,kernelSize)
%M - input matrix
%kernelSize - rectangular kernel size
%filteredImgae - image which is filtered

%convolve the kernel with input image
kernel = 1/kernelSize^2*ones(kernelSize,kernelSize);
filteredImage = imfilter(uint8(M),kernel,'conv','symmetric');

end

