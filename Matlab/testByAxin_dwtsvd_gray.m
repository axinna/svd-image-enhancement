% �Ҷ�ͼ
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\11.jpg');
originalImage=rgb2gray(originalImage);                                      %��Ҷ�ͼ
figure;imshow(originalImage);title('');
figure;
% originalImage=im2double(originalImage);            %��ͼ��unit8ת����double��������

%%
[LL   HL    LH    HH] = dwt2(originalImage, 'haar'); %��֣�amazing��
%%%%%%%%%%%%%%%%%%%%%LL�ڲ���ͼƬֱ�ӳ�����ȥ��Ч��
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