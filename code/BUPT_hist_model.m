%This function is to use as input histogram the histogram of an image M 
%and model the histogram of another image R according to the input.
%Or use as input histogram an approximation of the exponential
%distribution.

function modelledImage = BUPT_hist_model(M,R,mode)

%M - input image matrix
%R - reference image matrix
%mode - 1 use R as Reference
%     - 2 get exponential histogram
%modelledImage - image after modelling

%get M and R normailized histogram as pdf
inHist = BUPT_histogram(M);
referHist = BUPT_histogram(R);
[widthM,heightM] = size(M);
[widthR,heightR] = size(R);
pdfM = inHist/(heightM*widthM);
pdfR = referHist/(heightR*widthR);

acM = [];
for i = 1:256
    acM = [acM sum(pdfM(1:i))];%M pdf
end

acR = [];
if(mode == 1)%mode 1
    for i = 1:256
        acR = [acR sum(pdfR(1:i))];%reference pdf
    end
elseif(mode == 2)%mode 2
    for i = -255:0
        acR(i+256) = exp(i/40);%exp
    end
else
    error('You should give mode=1 or mode=2');
end

%get map matrix
for i=1:256
    differ{i} = abs(acM - acR(i));%get lowest point in of two pdf
    [~,map(i)] = min(differ{i});
end

%Map to the new grayscale
modelledImage = zeros(heightR,widthR);
for i=1:heightR
   for j=1:widthR
      modelledImage(i,j) = double(map(R(i,j)+1)-1);    
   end
end

end

