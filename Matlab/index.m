newImage=imread('C:\Users\Administrator\Documents\GitHub\svd-image-enhancement\Aerial image\111.png');
newImage=rgb2gray(newImage);                                      %��Ҷ�ͼ
%% ����ָ�� ��ֵ ��׼�� ��Ϣ�� ������ 
oriImgMean=mean2(originalImage)
oriImgStd =std2(originalImage)

gheImgMean=mean2(gheImage)
gheImgStd =std2(gheImage)

newImgMean=mean2(newImage)
newImgStd =std2(newImage)

Y=ssr11;
 p = imhist(Y(:));
% remove zero entries in p
   p(p==0) = [];  %%%�˴�����ͬ��
% normalize p so that sum(p) is one.
   p = p ./ numel(Y);
   H = -sum(p.*log2(p))

%Code