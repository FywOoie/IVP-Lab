%This function is implemented for equalizing histogram

function eqaulized = BUPT_equalise(M)

%M   - input image matrix
%histogram - output image matrix

%check if it is a grayscale image
[~,~,level] = size(M);
if(level~=1)
    error('You should pass a grayscale image to this function!');
end

eqaulized = histeq(uint8(M));%equalization using built-in matlab function histeq()

end

