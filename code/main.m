%% Exercise 1a
%read ppm or pgm images
figure('Name','Read ppm or pgm file')

%read P2 pepper
imgP2=BUPT_ReadImg('../dataset/Peppers512_ASCII2014.pgm');%magic identifier P2
subplot(2,2,1);
imshow(uint8(imgP2));
title('P2 pepper image');

%read P3 pepper
imgP3=BUPT_ReadImg('../dataset/Peppers512C_ASCII2014.ppm');%magic identifier P3
subplot(2,2,2);
imshow(uint8(imgP3));
title('P3 pepper image');

%read P5 pepper
imgP5=BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%magic identifier P5
subplot(2,2,3);
imshow(uint8(imgP5));
title('P5 pepper image');

%read P6 pepper
imgP6=BUPT_ReadImg('../dataset/Peppers512C_binary2014.ppm');%magic identifier P6
subplot(2,2,4);
imshow(uint8(imgP6));
title('P6 pepper image');

%save ppm or pgm images. read them and show them
figure('Name','Save ppm or pgm file then use read function to recover them')

%P2 pepper
BUPT_SaveAsPPMorPGM(imgP2,'../results/Exercise1/1a/1a-P2.pgm',1);%write P2
imgP2_recovered = BUPT_ReadImg('../results/Exercise1/1a/1a-P2.pgm');%read new file
subplot(2,2,1);
imshow(uint8(imgP2_recovered));
title('Recovered P2 pepper image');

%P3 pepper
BUPT_SaveAsPPMorPGM(imgP3,'../results/Exercise1/1a/1a-P3.ppm',1);%write P3
imgP3_recovered = BUPT_ReadImg('../results/Exercise1/1a/1a-P3.ppm');%read new file
subplot(2,2,2);
imshow(uint8(imgP3_recovered));
title('Recovered P3 pepper image');

%P5 pepper
BUPT_SaveAsPPMorPGM(imgP5,'../results/Exercise1/1a/1a-P5.pgm',0);%write P5
imgP5_recovered = BUPT_ReadImg('../results/Exercise1/1a/1a-P5.pgm');%read new file
subplot(2,2,3);
imshow(uint8(imgP5_recovered));
title('Recovered P5 pepper image');

%P6 pepper
BUPT_SaveAsPPMorPGM(imgP6,'../results/Exercise1/1a/1a-P6.ppm',0);%write P6
imgP6_recovered = BUPT_ReadImg('../results/Exercise1/1a/1a-P6.ppm');%read new file
subplot(2,2,4);
imshow(uint8(imgP6_recovered));
title('Recovered P6 pepper image');

%% Exercise 1b
%convert color ascii Baboon to grayscale ascii Baboon
yuv_ascii = BUPT_format_converter('../dataset/Baboon512C_ASCII2014.ppm','../results/Exercise1/1b/1b-Baboon-ascii.pgm',1);
figure('Name','ASCII convert')
subplot(1,2,1);
imshow('../dataset/Baboon512C_ASCII2014.ppm');title('Original ASCII color Baboon image');

subplot(1,2,2);
img_Baboon_1b_ascii = BUPT_ReadImg('../results/Exercise1/1b/1b-Baboon-ascii.pgm');
imshow(uint8(img_Baboon_1b_ascii));title('Transformed ASCII grayscale Baboon image');

%convert color binary Baboon to binary ascii Baboon
yuv_binary = BUPT_format_converter('../dataset/Baboon512C_Binary2014.ppm','../results/Exercise1/1b/1b-Baboon-binary.pgm',1);
figure('Name','Binary convert')
subplot(1,2,1),
imshow('../dataset/Baboon512C_Binary2014.ppm');title('Original Binary color Baboon image');

img_Baboon_1b_bianry = BUPT_ReadImg('../results/Exercise1/1b/1b-Baboon-binary.pgm');
subplot(1,2,2),
imshow(uint8(img_Baboon_1b_bianry));title('Transformed Binary grayscale Baboon image')

%transform lena from rgb to yuv
figure('Name','Lena YUV')
yuv_lena_1b = BUPT_format_converter('../dataset/Lena512C_ASCII2014.ppm','../results/Exercise1/1b/1b-Lena-ascii.ppm',2);
imshow('../results/Exercise1/1b/1b-Lena-ascii.ppm');

%transform lena from yuv to rgb
Y = yuv_lena_1b(:,:,1);%y
U = yuv_lena_1b(:,:,2);%u
V = yuv_lena_1b(:,:,3);%v
    
R = floor( 1.1641*Y - 0.0018*U + 1.5958*V - 222.6580 );%calculate r
G = floor( 1.1641*Y - 0.3914*U - 0.8135*V + 135.6041 );%calculate g
B = floor( 1.1641*Y + 2.0178*U - 0.0012*V - 276.7485 );%calculate b

rgb_lena_1b = cat(3,R,G,B);%concat three channels
BUPT_SaveAsPPMorPGM(rgb_lena_1b,'../results/Exercise1/1b/1b-Lena-yuv2rgb.ppm',1);%save to file
figure('Name','YUV to RGB')
imshow(uint8(rgb_lena_1b));
title('YUV converted to RGB');

%% Exercise 1c
lena_1c = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');
figure('Name','Sub-sampling')

%sample lena by 2by1
subplot(2,2,1)
lena_1c_h2 = BUPT_subSampler(lena_1c,1,2);%subsample
imshow(uint8(lena_1c_h2));title('2 by 1 subsample');
%BUPT_SaveAsPPMorPGM(lena_1c_h2,'../results/Exercise1/1c/1c-Lena-h2.pgm',1);%save the result

%sample lena by 1by2
subplot(2,2,2)
lena_1c_v2 = BUPT_subSampler(lena_1c,2,1);%subsample
imshow(uint8(lena_1c_v2));title('1 by 2 subsample');
%BUPT_SaveAsPPMorPGM(lena_1c_v2,'../results/Exercise1/1c/1c-Lena-v2.pgm',1);%save the result

%sample lena by 8by2
subplot(2,2,3)
lena_1c_v2h8 = BUPT_subSampler(lena_1c,2,8);%subsample
imshow(uint8(lena_1c_v2h8));title('8 by 2 subsample');
%BUPT_SaveAsPPMorPGM(lena_1c_v2h8,'../results/Exercise1/1c/1c-Lena-v2h8.pgm',1);%save the result

%sample lena by 4by4
subplot(2,2,4)
lena_1c_v4h4 = BUPT_subSampler(lena_1c,4,4);%subsample
imshow(uint8(lena_1c_v4h4));title('4 by 4 subsample');
%BUPT_SaveAsPPMorPGM(lena_1c_v4h4,'../results/Exercise1/1c/1c-Lena-v4h4.pgm',1);%save the result

%% Exercise 2a
figure('Name','Quantization')

%quantise lena by factor of 2
lena_2a = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');%read from dataset
subplot(2,2,1)
lena_2a_q2 = BUPT_quantizer(lena_2a,2);%quantize
imshow(uint8(lena_2a_q2));title('quantizetion by 2');
%BUPT_SaveAsPPMorPGM(lena_2a_q2,'../results/Exercise2/2a/2a-Lena-q2.pgm',0);%save the result

%quantise baboon by factor of 8
baboon_2a = BUPT_ReadImg('../dataset/Baboon512_binary2014.pgm');%read from dataset
subplot(2,2,2)
baboon_2a_q8 = BUPT_quantizer(baboon_2a,8);%quantize
imshow(uint8(baboon_2a_q8));title('quantizetion by 8');
%BUPT_SaveAsPPMorPGM(baboon_2a_q8,'../results/Exercise2/2a/2a-Baboon-q8.pgm',0);%save the result

%quantise peppers by factor of 32
peppers_2a = BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%read from dataset
subplot(2,2,3)
pepper_2a_q32 = BUPT_quantizer(peppers_2a,32);%quantize
imshow(uint8(pepper_2a_q32));title('quantizetion by 32');
%BUPT_SaveAsPPMorPGM(pepper_2a_q32,'../results/Exercise2/2a/2a-peppers-q32.pgm',0);%save the result

%quantise peppers by factor of 128
subplot(2,2,4)
pepper_2a_q128 = BUPT_quantizer(peppers_2a,128);%quantize
imshow(uint8(pepper_2a_q128));title('quantizetion by 128');
%BUPT_SaveAsPPMorPGM(pepper_2a_q128,'../results/Exercise2/2a/2a-peppers-q128.pgm',0);%save the result

%% Exercise 2b
figure('Name','histogram')

%lena histogram
lena_2b = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');%read from dataset
lena_2b_his = BUPT_histogram(lena_2b);%generate histogram
subplot(3,2,1),imshow(uint8(lena_2b));title('lena');
subplot(3,2,2),bar(lena_2b_his);title('lena histogram');
axis tight;

%baboon histogram
baboon_2b = BUPT_ReadImg('../dataset/Baboon512_binary2014.pgm');%read from dataset
baboon_2b_his = BUPT_histogram(baboon_2b);%generate histogram
subplot(3,2,3),imshow(uint8(baboon_2b));title('baboon');
subplot(3,2,4),bar(baboon_2b_his);title('baboon histogram');
axis tight;

%peppers histogram
pepper_2b = BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%read from dataset
pepper_2b_his = BUPT_histogram(pepper_2b);%generate histogram
subplot(3,2,5),imshow(uint8(pepper_2b));title('peppers');
subplot(3,2,6),bar(pepper_2b_his);title('peppers histogram');
axis tight;

%% Exercise 2c
figure('Name','equalized histogram')

%equalize lena
lena_2c = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');%read from dataset
subplot(3,3,1),imshow(uint8(lena_2c));title('original lena');
lena_2c_equalized  = BUPT_equalise(lena_2c);%eqaulize lena
subplot(3,3,2),imshow(lena_2c_equalized);title('equalized lena');
lena_2c_equalized_his = BUPT_histogram(lena_2c_equalized);%generate equalized histogram
subplot(3,3,3),bar(lena_2c_equalized_his);title('lena equalized histogram');
axis tight;

%equalize baboon
baboon_2c = BUPT_ReadImg('../dataset/Baboon512_binary2014.pgm');%read from dataset
subplot(3,3,4),imshow(uint8(baboon_2c));title('original baboon');
baboon_2c_equalized  = BUPT_equalise(baboon_2c);%eqaulize baboon
subplot(3,3,5),imshow(baboon_2c_equalized);title('equalized baboon');
baboon_2c_equalized_his = BUPT_histogram(baboon_2c_equalized);%generate equalized histogram
subplot(3,3,6),bar(baboon_2c_equalized_his);title('baboon equalized histogram');
axis tight;

%equalize peppers
pepper_2c = BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%read from dataset
subplot(3,3,7),imshow(uint8(pepper_2c));title('original pepper');
pepper_2c_equalized  = BUPT_equalise(pepper_2c);%eqaulize pepper
subplot(3,3,8),imshow(pepper_2c_equalized);title('equalized pepper');
pepper_2c_equalized_his = BUPT_histogram(pepper_2c_equalized);%generate equalized histogram
subplot(3,3,9),bar(pepper_2c_equalized_his);title('pepper equalized histogram');
axis tight;

%own version of equalization
figure('Name','my own equalized image')
me = imread('../dataset/me.jpg');
grayMe = rgb2gray(me);
subplot(1,2,1),imshow(grayMe);title('before equalisation')
newMe = BUPT_equalise(grayMe);
subplot(1,2,2),imshow(newMe);title('after equalisation')
%% Exercise 2d
figure('Name','Histogram Modelling');

%lena histogram
lena_2d = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');%read from dataset
lena_2d_his = BUPT_histogram(lena_2d);%generate histogram
subplot(3,2,1),imshow(uint8(lena_2d));title('lena');
subplot(3,2,2),bar(lena_2d_his);title('lena histogram');
axis tight;

%peppers histogram
pepper_2d = BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%read from dataset
pepper_2d_his = BUPT_histogram(pepper_2d);%generate histogram
subplot(3,2,3),imshow(uint8(pepper_2d));title('peppers');
subplot(3,2,4),bar(pepper_2d_his);title('peppers histogram');
axis tight;

%histogram modelling
pepper_2d_model = BUPT_hist_model(lena_2d,pepper_2d,1);%hist modelling
subplot(3,2,5),imshow(uint8(pepper_2d_model));title('peppers after modelling');
pepper_2d_model_his = BUPT_histogram(pepper_2d_model);%generate histogram
subplot(3,2,6),bar(pepper_2d_model_his);title('peppers modelled histogram');
axis tight;

figure('Name','Exponential shaped histogram');
pepper_2d_model_exp = BUPT_hist_model(lena_2d,pepper_2d,2);%hist modelling
subplot(1,2,1),imshow(uint8(pepper_2d_model_exp));
pepper_2d_model_his_exp = BUPT_histogram(pepper_2d_model_exp);%generate histogram
subplot(1,2,2),bar(pepper_2d_model_his_exp);title('peppers exp modelled histogram');
axis tight;
%% Exercise 3a
figure('Name','negative')

%lena negative
lena_3a_negative_g = BUPT_negative('../dataset/Lena512_binary2014.pgm');%negative gray
subplot(2,3,1),imshow(lena_3a_negative_g);title('lena gray negative')
lena_3a_negative_c = BUPT_negative('../dataset/Lena512C_binary2014.ppm');%negative color
subplot(2,3,4),imshow(lena_3a_negative_c);title('lena color negative')

%baboon negative
baboon_3a_negative_g = BUPT_negative('../dataset/Baboon512_binary2014.pgm');%negative gray
subplot(2,3,2),imshow(baboon_3a_negative_g);title('baboon gray negative')
baboon_3a_negative_c = BUPT_negative('../dataset/Baboon512C_binary2014.ppm');%negative color
subplot(2,3,5),imshow(baboon_3a_negative_c);title('baboon color negative')

%pepper negative
pepper_3a_negative_g = BUPT_negative('../dataset/Peppers512_binary2014.pgm');%negative gray
subplot(2,3,3),imshow(pepper_3a_negative_g);title('pepper gray negative')
pepper_3a_negative_c = BUPT_negative('../dataset/Peppers512C_binary2014.ppm');%negative color
subplot(2,3,6),imshow(pepper_3a_negative_c);title('pepper color negative')

%% Exercise 3b
%read lyb.jpg from dataset
lyb_3b_img = rgb2gray(imread('../dataset/lyb.jpg'));
BUPT_SaveAsPPMorPGM(double(lyb_3b_img),'../results/Exercise3/3b/lyb.pgm',1);
figure('Name','lyb')
imshow('../results/Exercise3/3b/lyb.pgm');

%rotate by four different degrees
figure('Name','Rotate')
lyb_3b_rotate30 = BUPT_transform(double(lyb_3b_img),30,0);%rotate 30 degrees
subplot(2,2,1),imshow(uint8(lyb_3b_rotate30));title('rotate 30');
lyb_3b_rotate60 = BUPT_transform(double(lyb_3b_img),60,0);%rotate 60 degrees
subplot(2,2,2),imshow(uint8(lyb_3b_rotate60));title('rotate 60');
lyb_3b_rotate120 = BUPT_transform(double(lyb_3b_img),120,0);%rotate 120 degrees
subplot(2,2,3),imshow(uint8(lyb_3b_rotate120));title('rotate 120');
lyb_3b_rotate50m = BUPT_transform(double(lyb_3b_img),-50,0);%rotate -50 degrees
subplot(2,2,4),imshow(uint8(lyb_3b_rotate50m));title('rotate -50');

%skew by four different degrees
figure('Name','Skew')
lyb_3b_skew10 = BUPT_transform(double(lyb_3b_img),0,10);
subplot(3,1,1),imshow(uint8(lyb_3b_skew10));title('skew 10');
lyb_3b_skew40 = BUPT_transform(double(lyb_3b_img),0,40);
subplot(3,1,2),imshow(uint8(lyb_3b_skew40));title('skew 40');
lyb_3b_skew60 = BUPT_transform(double(lyb_3b_img),0,60);
subplot(3,1,3),imshow(uint8(lyb_3b_skew60));title('skew 60');

%rotate than skew
figure('Name','Rotate than Skew')
lyb_3b_r20s50 = BUPT_transform(double(lyb_3b_img),20,50);
subplot(2,1,1),imshow(uint8(lyb_3b_r20s50));title('Rotate 20 and Skew 50');
lyb_3b_r50s20 = BUPT_transform(double(lyb_3b_img),50,20);
subplot(2,1,2),imshow(uint8(lyb_3b_r50s20));title('Rotate 50 and Skew 20');

%% Exercise 4a
%read lena, pepper and baboon
lena_4a = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');%read from dataset
pepper_4a = BUPT_ReadImg('../dataset/Peppers512_binary2014.pgm');%read from dataset
baboon_4a = BUPT_ReadImg('../dataset/Baboon512_binary2014.pgm');%read from dataset

figure('Name','add noise')
%salt and pepper noise to lena, pepper and baboon
[lena_4a_saltPepper,MSE_lena_4a_saltPepper,PSNR_lena_4a_saltPepper] = BUPT_addNoise(lena_4a,'salt & pepper');
subplot(3,3,1),imshow(uint8(lena_4a_saltPepper));
title(strcat('MSE=',num2str(MSE_lena_4a_saltPepper),', PSNR=',num2str(PSNR_lena_4a_saltPepper)));

[pepper_4a_saltPepper,MSE_pepper_4a_saltPepper,PSNR_pepper_4a_saltPepper] = BUPT_addNoise(pepper_4a,'salt & pepper');
subplot(3,3,2),imshow(uint8(pepper_4a_saltPepper));
title(strcat('MSE=',num2str(MSE_pepper_4a_saltPepper),', PSNR=',num2str(PSNR_pepper_4a_saltPepper)));

[baboon_4a_saltPepper,MSE_baboon_4a_saltPepper,PSNR_baboon_4a_saltPepper] = BUPT_addNoise(baboon_4a,'salt & pepper');
subplot(3,3,3),imshow(uint8(baboon_4a_saltPepper));
title(strcat('MSE=',num2str(MSE_baboon_4a_saltPepper),', PSNR=',num2str(PSNR_baboon_4a_saltPepper)));

%guassian noise of low variance to lena, pepper and baboon
[lena_4a_g1,MSE_lena_4a_g1,PSNR_lena_4a_g1] = BUPT_addNoise(lena_4a,'gaussian',0.01);
subplot(3,3,4),imshow(uint8(lena_4a_g1));
title(strcat('MSE=',num2str(MSE_lena_4a_g1),', PSNR=',num2str(PSNR_lena_4a_g1)));

[pepper_4a_g2,MSE_pepper_4a_g2,PSNR_pepper_4a_g2] = BUPT_addNoise(pepper_4a,'gaussian',0.02);
subplot(3,3,5),imshow(uint8(pepper_4a_g2));
title(strcat('MSE=',num2str(MSE_pepper_4a_g2),', PSNR=',num2str(PSNR_pepper_4a_g2)));

[baboon_4a_g7,MSE_baboon_4a_g7,PSNR_baboon_4a_g7] = BUPT_addNoise(baboon_4a,'gaussian',0.07);
subplot(3,3,6),imshow(uint8(baboon_4a_g7));
title(strcat('MSE=',num2str(MSE_baboon_4a_g7),', PSNR=',num2str(PSNR_baboon_4a_g7)));

%guassian noise of high variance to lena, pepper and baboon
[lena_4a_g5,MSE_lena_4a_g5,PSNR_lena_4a_g5] = BUPT_addNoise(lena_4a,'gaussian',0.05);
subplot(3,3,7),imshow(uint8(lena_4a_g5));
title(strcat('MSE=',num2str(MSE_lena_4a_g5),', PSNR=',num2str(PSNR_lena_4a_g5)));

[pepper_4a_g5,MSE_pepper_4a_g5,PSNR_pepper_4a_g5] = BUPT_addNoise(pepper_4a,'gaussian',0.05);
subplot(3,3,8),imshow(uint8(pepper_4a_g5));
title(strcat('MSE=',num2str(MSE_pepper_4a_g5),', PSNR=',num2str(PSNR_pepper_4a_g5)));

[baboon_4a_g10,MSE_baboon_4a_g10,PSNR_baboon_4a_g10] = BUPT_addNoise(baboon_4a,'gaussian',0.1);
subplot(3,3,9),imshow(uint8(baboon_4a_g10));
title(strcat('MSE=',num2str(MSE_baboon_4a_g10),', PSNR=',num2str(PSNR_baboon_4a_g10)));

%% Exercise 4b
figure('Name','Up-sampled Image')

%up-sample lena by factor 4.5
lena_4b = BUPT_ReadImg('../dataset/Lena512C_binary2014.ppm');
lena_4b_upSample4p5 = BUPT_up(lena_4b,'nearest',4.5,4.5);%upsample by 4.5
subplot(2,2,1),imshow(uint8(lena_4b));title('Original Lena');
subplot(2,2,2),imshow(uint8(lena_4b_upSample4p5));title('Upsampled 4.5 Lena');

%upsample baboon by factor 3.6
baboon_4b = BUPT_ReadImg('../dataset/Baboon512_binary2014.pgm');
baboon_4b_upSample3p6 = uint8(BUPT_up(baboon_4b,'bilinear',3.6,3.6));%upsample by 3.6
subplot(2,2,3),imshow(uint8(baboon_4b));title('Original Baboon');
subplot(2,2,4),imshow(uint8(baboon_4b_upSample3p6));title('Upsampled 3.6 Baboon');

%% Exercise 5a
figure('Name','Image Filter');

%add gussian nosie to lena
lena_5a = BUPT_ReadImg('../dataset/Lena512C_binary2014.ppm');
%did not use BUPT_addNoise for it can only add noise to pgm image
lena_5a_noise = double(imnoise(uint8(lena_5a),'gaussian',0.05));
subplot(3,3,1),imshow(uint8(lena_5a_noise));title('guassian noise');

%apply lowpass filter to noise image
lena_5a_0p5 = BUPT_lowpass(lena_5a_noise,10,0.5);
subplot(3,3,2),imshow(uint8(lena_5a_0p5));title('guassian filter σ 0.5');%σ=0.5
lena_5a_1 = BUPT_lowpass(lena_5a_noise,10,1);
subplot(3,3,3),imshow(uint8(lena_5a_1));title('guassian filter σ 1');%σ=1
lena_5a_2 = BUPT_lowpass(lena_5a_noise,10,2);
subplot(3,3,4),imshow(uint8(lena_5a_2));title('guassian filter σ 2');%σ=2
lena_5a_4 = BUPT_lowpass(lena_5a_noise,10,4);
subplot(3,3,5),imshow(uint8(lena_5a_4));title('guassian filter σ 4');%σ=4
lena_5a_7 = BUPT_lowpass(lena_5a_noise,10,7);
subplot(3,3,6),imshow(uint8(lena_5a_7));title('guassian filter σ 7');%σ=7
lena_5a_10 = BUPT_lowpass(lena_5a_noise,10,10);
subplot(3,3,7),imshow(uint8(lena_5a_10));title('guassian filter σ 10');%σ=10

%apply rectangular filter to the noise image
lena_5a_rect5 = BUPT_rect(lena_5a_noise,5);
subplot(3,3,8),imshow(uint8(lena_5a_rect5));title('rectangular filter size 5');%5 by 5
lena_5a_rect7 = BUPT_rect(lena_5a_noise,7);
subplot(3,3,9),imshow(uint8(lena_5a_rect7));title('rectangular filter size 7');%7 by 7

%% Exercise 5b
figure('Name','Edge Detection');

%Original image
lena_5b = BUPT_ReadImg('../dataset/Lena512_binary2014.pgm');
subplot(2,4,1),imshow(uint8(lena_5b));title('Gray Lena');
pepper_5b = BUPT_ReadImg('../dataset/Peppers512C_binary2014.ppm');
subplot(2,4,5),imshow(uint8(pepper_5b));title('Color Pepper');

%gray Lena edge detection
lena_5b_sobel = BUPT_edge(lena_5b,'sobel');
subplot(2,4,2),imshow(uint8(lena_5b_sobel));title('Gray Lena Sobel');
lena_5b_robert = BUPT_edge(lena_5b,'roberts');
subplot(2,4,3),imshow(uint8(lena_5b_robert));title('Gray Lena Roberts');
lena_5b_prewitt = BUPT_edge(lena_5b,'prewitt');
subplot(2,4,4),imshow(uint8(lena_5b_prewitt));title('Gray Lena Prewitt');

%color Peppers edge detection
pepper_5b_sobel = BUPT_edge(pepper_5b,'sobel');
subplot(2,4,6),imshow(uint8(pepper_5b_sobel));title('Color Peppers Sobel');
pepper_5b_robert = BUPT_edge(pepper_5b,'roberts');
subplot(2,4,7),imshow(uint8(pepper_5b_robert));title('Color Peppers Roberts');
pepper_5b_prewitt = BUPT_edge(pepper_5b,'prewitt');
subplot(2,4,8),imshow(uint8(pepper_5b_prewitt));title('Color Peppers Prewitt');

%% Exercise 6
figure('Name','Guassian Laplace operator');

%lena log σ=1
lena_6 = BUPT_ReadImg('../dataset/Lena512C_binary2014.ppm');
subplot(3,3,1),imshow(uint8(lena_6));title('Lena');
lena_6_log1 = BUPT_LoG(lena_6,8,1);%Lena σ=1
subplot(3,3,2),imshow(lena_6_log1,[]);title('log lena σ=1');

%peppers log σ=3
pepper_6 = BUPT_ReadImg('../dataset/Peppers512C_binary2014.ppm');
subplot(3,3,4),imshow(uint8(pepper_6));title('Peppers');
pepper_6_log3 = BUPT_LoG(pepper_6,10,3);%Peppers σ=3
subplot(3,3,5),imshow(pepper_6_log3,[]);title('log pepper σ=3');

%baboon log σ=1,2,3
babbon_6 = BUPT_ReadImg('../dataset/Baboon512C_binary2014.ppm');
babbon_6_log1 = BUPT_LoG(babbon_6,10,1);%Baboon σ=1
subplot(3,3,7),imshow(babbon_6_log1,[]);title('log baboon σ=1');
babbon_6_log2 = BUPT_LoG(babbon_6,10,2);%Baboon σ=2
subplot(3,3,8),imshow(babbon_6_log2,[]);title('log baboon σ=2');
babbon_6_log3 = BUPT_LoG(babbon_6,10,3);%Baboon σ=3
subplot(3,3,9),imshow(babbon_6_log3,[]);title('log baboon σ=3');

figure('Name','Small Kernel Result');
%lena small
lena_6_small = BUPT_LoG(lena_6,5,1);
subplot(1,2,1),imshow(lena_6_small,[]);title('lena small');

%peppers small
pepper_6_small = BUPT_LoG(pepper_6,5,1);
subplot(1,2,2),imshow(pepper_6_small,[]);title('pepper small');