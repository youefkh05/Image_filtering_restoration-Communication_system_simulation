function   show_images(im1,im2,mes1,mes2)   % picture1,2 and their names  
%SHOW_IMAGES Summary of this function goes here
%it shows them beside each other
%   Detailed explanation goes here
figure();       %open a figure
subplot(1,2,1); %divide it into half and choose the first half
imshow(im1);    %show the first picture
xlabel(mes1);   %first picture name
subplot(1,2,2); %the second half
imshow(im2);    %show the first picture
xlabel(mes2);   %second picture name
end

