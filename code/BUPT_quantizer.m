%This function is to quantize an image by a given quantization factor

function img = BUPT_quantizer(M,factor)

%M - input garyscale image matrix
%factor - quantisation factor, which should be power of 2
%img - output image matrix

%make sure input is grayscale image and factor is power of 2
[~,~,level] = size(M);
if(level~=1)
    error('You should pass a grayscale image to this function!');
end
if(rem(log2(factor),1)~=0)
    error('You should pass a factor which is power of 2 to this function!');
end

%quantisation
temp = round(M/factor/2);
img = temp * factor * 2 - 1;
img(img == -1) = 0;%make all -1 element to 0

end

