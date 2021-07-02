%This function is to sub sample an image matrix by factors of horizental
%and vertical.

function img = BUPT_subSampler(M,xFactor,yFactor)
%M - input image matrix,it should be a grayscale matrix
%xFactor - horizental sampling factor, if you dont want it, set it to 1
%yFactor - vertical sampling factor, if you dont want it, set it to 1

%check for grayscale image
[width,height,level] = size(M);
if(level~=1)
    error('You should pass a grayscale image to this function!');
end
%check for sampling factors, that is not larger than half of width or
%height and be a multiple of 2 if it is not 1
if((xFactor>=(width/2)) || (xFactor>=(height/2)))
    error('Factor larger than limit!');
elseif(mod(xFactor,2)~=0 && xFactor~=1)
    error('x Factor should be n multiple of 2!')
elseif(mod(yFactor,2)~=0 && yFactor~=1)
    error('y Factor should be n multiple of 2!')
end

a = ceil(width/xFactor);% a samples each row
b = ceil(height/yFactor);% b samples each column
img = zeros(a,b);% preallocate memory for sampled result

for i = 1:a
    for j = 1:b
        img(i,j) = M(1+xFactor*(i-1),1+yFactor*(j-1));% subsampling
    end
end

%This can interplote to original size
%img = kron(temp,ones(xFactor,yFactor));% interpolate using Kronecker
%img = img(1:width,1:height);% truncate the image into its original size

end
