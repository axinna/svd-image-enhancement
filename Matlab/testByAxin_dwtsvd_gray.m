% 灰度图
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\14.jpg');
originalImage=rgb2gray(originalImage);                                      %变灰度图
figure;imshow(originalImage);title('原始图像');
figure;


%%
[LL   HL    LH    HH] = dwt2(originalImage, 'haar'); 
[U    S     V       ] = svd(LL, 'econ');

gheImage=GHE_gray(originalImage);
figure;imshow(gheImage);title('直方均衡');
figure;

[LLGHE   HLGHE    LHGHE    HHGHE] = dwt2(gheImage, 'haar');
[UGHE    SGHE     VGHE          ] = svd(LLGHE, 'econ'); 

weight=max(SGHE)/max(S);
newS=weight*S;
newLL=U*newS*V';
newImage = idwt2(newLL, HL, LH, HH, 'haar');
imshow(newImage,[]);title('dwtsvd图像');