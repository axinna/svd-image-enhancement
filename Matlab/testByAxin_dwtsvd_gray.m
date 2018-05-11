% 灰度图
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\11.jpg');
originalImage=rgb2gray(originalImage);                                      %变灰度图
figure;imshow(originalImage);title('');
figure;
% originalImage=im2double(originalImage);            %把图像unit8转换成double精度类型

%%
[LL   HL    LH    HH] = dwt2(originalImage, 'haar'); %奇怪！amazing！
%%%%%%%%%%%%%%%%%%%%%LL在部分图片直接出现了去雾效果
figure;imshow(LL,[])
idwt2(LL, HL, LH, HH, 'haar');
figure;imshow(ans,[])
%%%%%%%%%%%%%%%%%%%%%%%
[U    S     V       ] = svd(LL, 'econ');

gheImage=GHE_gray(originalImage);
figure;imshow(gheImage);title('he');
figure;

[LLGHE   HLGHE    LHGHE    HHGHE] = dwt2(gheImage, 'haar');
[UGHE    SGHE     VGHE          ] = svd(LLGHE, 'econ'); 

weight=max(SGHE)/max(S);
newS=weight*S;
newLL=U*newS*V';
newImage = idwt2(newLL, HL, LH, HH, 'haar');
%newImage=im2uint8(newImage);
newImage=round(newImage);
imshow(newImage,[]);title('');
figure;imhist(newImage/256);

% finalImage=im2uint8(finalImage);  %把矩阵double转换成uint8类型
% figure;imshow(finalImage);
%% 评价指标 均值 标准差 信息熵 清晰度 
oriImgMean=mean2(originalImage)
oriImgStd =std2(originalImage)

gheImgMean=mean2(gheImage)
gheImgStd =std2(gheImage)

newImgMean=mean2(newImage)
newImgStd =std2(newImage)

%% histogram image

load('ssr11.mat'); 
ssrImage=ssr11; 
figure;imshow(ssrImage);title('ssr');
figure;                                 set(gca,'xtick',-inf:inf:inf);
subplot(421);imshow(originalImage);     
subplot(422);imhist(originalImage);     set(gca,'xtick',-inf:inf:inf);
subplot(423);imshow(gheImage);          
subplot(424);imhist(gheImage);          set(gca,'xtick',-inf:inf:inf);
subplot(425);imshow(ssrImage);          
subplot(426);imhist(ssrImage);          set(gca,'xtick',-inf:inf:inf);
subplot(427);imshow(newImage,[]);       
subplot(428);imhist(newImage/256);      set(gca,'xtick',-inf:inf:inf);  %由于格式问题：/256

%% waveTest
sizeLL=size(LL);
ReplaceBlack   = zeros(sizeLL(1),sizeLL(2));
ReplaceImageLL = idwt2(ReplaceBlack, HL, LH, HH, 'haar');
ReplaceImageAll= idwt2(newLL, ReplaceBlack, ReplaceBlack, ReplaceBlack, 'haar');
figure;
subplot(221);imshow(HL);subplot(222);imshow(LH);
subplot(223);imshow(HH);subplot(224);imshow(ReplaceImageLL);

figure;imhist(newLL/max(max(newLL)));title('newLL')
figure;imshow(newLL,[]);title('newLL')
figure;imshow(newImage,[]);title('newImage')
figure;imshow(newImage,[]);title('ReplaceImageAll')

% figure;imshow([LL HL;LH HH],[]);title('DWT')
%imrite(uint8(a),'tested.jpg','jpg');
figure;imshow(uint8(newImage));