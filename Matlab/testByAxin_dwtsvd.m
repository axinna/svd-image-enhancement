% 南村群童欺我老无力 印度阿三坑我！
clear all;
close all;
clc;
%%
originalImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\0.jpg');
figure;imshow(originalImage);
%originalImage=im2double(originalImage);            %把图像unit8转换成double精度类型 参考：https://blog.csdn.net/colddie/article/details/6684834

%% PART ONE: dwt of originalImage->LL1 LH1 HL1 HH1(r g b) ,and then svd of LL->
%   U1 ,sigema1 and V1 
%%%%%%%%%%%%
[LLr   HLr    LHr    HHr] = dwt2(originalImage(:,:,1), 'haar');  %red channel
[Ur    Sr     Vr         ] = svd(LLr, 'econ');                   %LLr = U*S*V'.
[LLg   HLg    LHg    HHg] = dwt2(originalImage(:,:,2), 'haar');  %gree channel
[Ug    Sg     Vg         ] = svd(LLr, 'econ');
[LLb   HLb    LHb    HHb] = dwt2(originalImage(:,:,3), 'haar');  %blue channel
[Ub    Sb     Vb         ] = svd(LLb, 'econ');



%% PART TWO: GHE(general histogram equalization) of originalImage->gheImage
%               and then ,dwt of gheImage->LL2 LH2 HL2 HH2 ,and then svd of LL->
%               U2 ,sigema2 and V2 
%%%%%%%%%%%%
gheImage=GHE_color(originalImage);                  %
figure;imshow(gheImage,[]);  
[LLrGHE   HLrGHE    LHrGHE    HHrGHE] = dwt2(gheImage(:,:,1), 'haar');  %red channel
[LLgGHE   HLgGHE    LHgGHE    HHgGHE] = dwt2(gheImage(:,:,2), 'haar');  %gree channel 
[LLbGHE   HLbGHE    LHbGHE    HHbGHE] = dwt2(gheImage(:,:,3), 'haar');  %blue channel            
[UrGHE    SrGHE     VrGHE         ] = svd(LLrGHE, 'econ'); 
[UgGHE    SgGHE     VgGHE         ] = svd(LLgGHE, 'econ');
[UbGHE    SbGHE     VbGHE         ] = svd(LLbGHE, 'econ');





%% PART THREE:
ParaOfWei=1; %parameter of weight
tmpr=0;
tmpg=0;
tmpb=0;

tmpGHEr=0;
tmpGHEg=0;
tmpGHEb=0;

for wi=1:ParaOfWei
    tmpr=Sr(wi,wi)+tmpr;
    tmpg=Sg(wi,wi)+tmpg;
    tmpb=Sb(wi,wi)+tmpb;
    
    tmpGHEr=SrGHE(wi,wi)+tmpGHEr;
    tmpGHEg=SgGHE(wi,wi)+tmpGHEg;
    tmpGHEb=SbGHE(wi,wi)+tmpGHEb;
    
end
weight_r=tmpGHEr/tmpr;
weight_g=tmpGHEg/tmpg;
weight_b=tmpGHEb/tmpb;



newSr=weight_r*Sr;
newSg=weight_g*Sg;
newSb=weight_b*Sb;

newLLr=Ur*newSr*Vr';
newLLg=Ug*newSg*Vg';
newLLb=Ub*newSb*Vb';



newImage_r = idwt2(newLLr, HLr, LHr, HHr, 'haar');
newImage_g = idwt2(newLLg, HLg, LHg, HHg, 'haar');
newImage_b = idwt2(newLLb, HLb, LHb, HHb, 'haar');

% newLLrGHE=UrGHE*SrGHE*VrGHE';                              %检测svd是否有问题 不用时应该屏蔽
% newLLgGHE=UgGHE*SgGHE*VgGHE';                              %结果没有问题
% newLLbGHE=UbGHE*SbGHE*VbGHE';
% newImage_r = idwt2(newLLrGHE, HLrGHE, LHrGHE, HHrGHE, 'haar');
% newImage_g = idwt2(newLLgGHE, HLgGHE, LHgGHE, HHgGHE, 'haar');
% newImage_b = idwt2(newLLbGHE, HLbGHE, LHbGHE, HHbGHE, 'haar');

testImage=cat(3,newLLr,newLLg,newLLb);
newImage=cat(3,newImage_r,newImage_g,newImage_b);
figure,imshow(uint8(newImage));

% weight_r=(max(max(UrGHE))+max(max(VrGHE)))/(max(max(Ur))+max(max(Vr)));
% weight_g=(max(max(UgGHE))+max(max(VgGHE)))/(max(max(Ug))+max(max(Vg)));
% weight_b=(max(max(UbGHE))+max(max(VbGHE)))/(max(max(Ub))+max(max(Vb)));
% 
% newSr=weight_r*Sr;
% newSg=weight_g*Sg;
% newSb=weight_b*Sb;
% 
% newLLr=UrGHE*newSr*VrGHE';
% newLLg=UgGHE*newSg*VgGHE';
% newLLb=UbGHE*newSb*VbGHE';
%%
% [LL, HL, LH, HH] = dwt2(originalImage, 'haar');
% finalImage = idwt2(LL, HL, LH, HH, 'haar');
% finalImage=im2uint8(finalImage);  %把矩阵double转换成uint8类型
% figure;imshow(finalImage);






















































