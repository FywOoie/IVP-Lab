%This function is to calculate the histogram of an image

function histogram = BUPT_histogram(M)

%M  - input image matrix
%histogram - output image matrix

%check if it is a grayscale image
[width,height,level] = size(M);
if(level~=1)
    error('You should pass a grayscale image to this function!');
end

histogram = zeros(1,256);%preallocate memory
for i = 1:width
   for j = 1:height
      %generate histogram
      k = M(i, j);%get intensity level
      histogram(k+1) = histogram(k+1) + 1;%add one to the number of this intensity level
   end
end

end

