clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\11.jpg');
figure;imshow(originalImage);
originalImage=im2double(originalImage);            %��ͼ��unit8ת����double�������� �ο���https://blog.csdn.net/colddie/article/details/6684834

%% PART ONE: dwt of originalImage->LL1 LH1 HL1 HH1 ,and then svd of LL->
%   U1 ,sigema1 and V1 
[LL, HL, LH, HH] = dwt2(originalImage, 'haar');

%% PART TWO: GHE(general histogram equalization) of originalImage->gheImage
%               and then ,dwt of gheImage->LL2 LH2 HL2 HH2 ,and then svd of LL->
%               U2 ,sigema2 and V2 





%%
% [LL, HL, LH, HH] = dwt2(originalImage, 'haar');
% finalImage = idwt2(LL, HL, LH, HH, 'haar');
% finalImage=im2uint8(finalImage);  %�Ѿ���doubleת����uint8����
% figure;imshow(finalImage);






















































