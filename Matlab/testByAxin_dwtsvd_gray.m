% �Ҷ�ͼ
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\14.jpg');
originalImage=rgb2gray(originalImage);                                      %��Ҷ�ͼ
figure;imshow(originalImage);title('ԭʼͼ��');
figure;


%%
[LL   HL    LH    HH] = dwt2(originalImage, 'haar'); 
[U    S     V       ] = svd(LL, 'econ');

gheImage=GHE_gray(originalImage);
figure;imshow(gheImage);title('ֱ������');
figure;

[LLGHE   HLGHE    LHGHE    HHGHE] = dwt2(gheImage, 'haar');
[UGHE    SGHE     VGHE          ] = svd(LLGHE, 'econ'); 

weight=max(SGHE)/max(S);
newS=weight*S;
newLL=U*newS*V';
newImage = idwt2(newLL, HL, LH, HH, 'haar');
imshow(newImage,[]);title('dwtsvdͼ��');