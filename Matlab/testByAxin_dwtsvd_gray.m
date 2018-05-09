% �Ҷ�ͼ
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\11.jpg');
originalImage=rgb2gray(originalImage);                                      %��Ҷ�ͼ
figure;imshow(originalImage);title('ԭʼͼ��');
figure;
%originalImage=im2double(originalImage);            %��ͼ��unit8ת����double��������

%%
[LL   HL    LH    HH] = dwt2(originalImage, 'haar'); 
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
imshow(newImage,[]);title('dwtsvd');
figure;imhist(newImage/256);

% finalImage=im2uint8(finalImage);  %�Ѿ���doubleת����uint8����
% figure;imshow(finalImage);
%% ����ָ�� ��ֵ ��׼�� ��Ϣ�� ������ 
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
subplot(428);imhist(newImage/256);      set(gca,'xtick',-inf:inf:inf);  %���ڸ�ʽ���⣺/256


