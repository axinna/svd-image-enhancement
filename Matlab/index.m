newImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\111.png');
newImage=rgb2gray(newImage);                                      %变灰度图
%% 评价指标 均值 标准差 信息熵 清晰度 
oriImgMean=mean2(originalImage)
oriImgStd =std2(originalImage)

gheImgMean=mean2(gheImage)
gheImgStd =std2(gheImage)

newImgMean=mean2(newImage)
newImgStd =std2(newImage)

Y=ssr11;
 p = imhist(Y(:));
% remove zero entries in p
   p(p==0) = [];  %%%此处于上同理。
% normalize p so that sum(p) is one.
   p = p ./ numel(Y);
   H = -sum(p.*log2(p))

%Code