%This function is to rotate the input image by angle1 and skew by angle2

function transformedImage = BUPT_transform(I,angle1,angle2)

%I：input grayscale image matrix
%angle1: angle in degree that the image is about to rorate
%angle2: angle in degree that the image is about to skew
%transformedImage: output image matrix

%check if it is a grayscale image
[width,height,level] = size(I);
if(level~=1)
    disp('You should pass in a gray scale image matrix to this function');
    return;
end

%get the cos and sin of the two angles
ang1 = angle1/180*pi;
ang2 = -(90-angle2)/180*pi;
cosRotate = cos(ang1);
sinRotate = sin(ang1);

%newWidth=round(width*abs(cosRotate)+height*abs(sinRotate));%new width of the image
%newHeight=round(width*abs(sinRotate)+height*abs(cosRotate));%new height of the image
%transformedImage=zeros(newWidth,newHeight);%preallocate image size

%transformation of coordinates
if(angle1 == 0)
    R = [1 0 0;0 1 0;0 0 1];%default transformation matrixthat will not change pixel values
else
    R = [cosRotate -sinRotate 0;sinRotate cosRotate 0;0 0 1];%rotate operator
end

if(angle2 == 0)
    S = [1 0 0;0 1 0;0 0 1];%default transformation matrixthat will not change pixel values
else
    S=[1 1/(tan(ang2)) 0;0 1 0;0 0 1];%skew operator
end

T = R*S;%transformation operator that firstly rotate than skew the image

temp1 = T*[1 1 1]';
temp2 = T*[width height 1]';
temp3 = T*[1 height 1]';
temp4 = T*[width 1 1]';

%adjust to the new size
newMax = max(temp1,max(temp2,max(temp3,temp4)));
newMin = min(temp1,min(temp2,min(temp3,temp4)));
newMax = round(newMax);
newMin = round(newMin);
wNew = newMax(1) - newMin(1)+1;
hNew = newMax(2) - newMin(2)+1;
transformedImage = zeros(hNew,wNew);%preallocate image size

%apply transformation operator to the image
for i = 1:height
    for j = 1:width
        coorinate = T*[j i 1]';
        transformedImage(round(coorinate(2))-newMin(2)+1,1+round(coorinate(1))-newMin(1)) = I(i,j);
    end
end

% solve the black pixels problem
for i = 1:hNew
    for j = 1:wNew
        if transformedImage(i,j)==0
            oldCoordinate=round(inv(T)*[j+newMin(1)-1 i+newMin(2)-1 1]');
            if((oldCoordinate(1) > 0) && (oldCoordinate(2) > 0) && (oldCoordinate(1) < width) && (oldCoordinate(2) < height))
                transformedImage(i,j) = I(oldCoordinate(2),oldCoordinate(1));
            end
        end
    end
end

end
