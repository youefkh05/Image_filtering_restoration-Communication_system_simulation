clc         %clear the command window
clear       %clear the workspace to start
default =1; %if you want the default picture
%Section A
if default==1
    pic=imread('peppers.png');       %default picture 
else
    [file,path]=uigetfile('*.*');    %locate the picture   
    picp=strcat(path,file);          %picture path = "path"+"file"
    pic=imread(picp);                %read the picture
end
show_colors(pic);                    %show all colors

pause(3);                %wait 3 seconds

%Section B
gray_pic=rgb2gray(pic);                                 %get the gray picture
edge_kernel=[0 1 0;
            1 -4 1;
            0 1 0]/90;                    %edge kernel 
edge_pic = conv2(gray_pic, edge_kernel);                %convelute the kernal with the picture
show_images(pic,edge_pic,"Orignal","Edge detection");   %show the orignal and edge picture
imwrite(edge_pic,"image1.png");                         %save the edge picture

pause(3);                %wait 3 seconds

%Section C
sharp_kernel = [0, -1, 0;
               -1, 5, -1;
                0, -1, 0]/255  %sharp kernel 
sharp_pic(:,:,1) = conv2(pic(:,:,1), sharp_kernel); %convelute the kernal with the red part of picture
sharp_pic(:,:,2) = conv2(pic(:,:,2), sharp_kernel); %convelute the kernal with the green part of picture
sharp_pic(:,:,3) = conv2(pic(:,:,3), sharp_kernel); %convelute the kernal with the blue part of picture
show_images(pic,sharp_pic,"Orignal","Sharp");       %show the orignal and sharp picture
imwrite(sharp_pic,"image2.png");                    %save the sharp picture

pause(3);                %wait 3 seconds

%Section D
blur_kernel=[1 1 1;
             1 1 1;
             1 1 1]/(9*255)           %blur kernel 
blur_pic(:,:,1)=conv2(pic(:,:,1), blur_kernel);    %convelute the kernal with the red part of picture
blur_pic(:,:,2)=conv2(pic(:,:,2), blur_kernel);    %convelute the kernal with the green part of picture
blur_pic(:,:,3)=conv2(pic(:,:,3), blur_kernel);    %convelute the kernal with the blue part of picture
show_images(pic,blur_pic,"Orignal","Blur");        %show the orignal and blur picture
imwrite(blur_pic,"image3.png");                    %save the blur picture

pause(3);                %wait 3 seconds

%Section E
    motion_kernel_size=19;
    motion_kernel=[
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    ]/(motion_kernel_size*255);                     %motion kernel
motion_pic(:,:,1)=conv2(pic(:,:,1),motion_kernel);  %convelute the kernal with the red part of picture 
motion_pic(:,:,2)=conv2(pic(:,:,2),motion_kernel);  %convelute the kernal with the green part of picture
motion_pic(:,:,3)=conv2(pic(:,:,3),motion_kernel);  %convelute the kernal with the blue part of picture
[row,column] = size(motion_pic(:,:  ,1));             %take the pic size
%show the orignal and motion picture
show_images(pic,motion_pic(19:row-19,19:column-19,:),"Orignal","Motion");     
imwrite(motion_pic(19:row-19,19:column-19,:),"image4.png");                   
%save the motion picture and we reduce the frame

pause(3);                %wait 3 seconds

%Section F
pad_motion_kernel = zeros(row,column);              %intial the kernel
pad_motion_kernel(1: motion_kernel_size,1: motion_kernel_size) = motion_kernel; 
%making the pad

%Fourier transform
motion_kernel_fft(:,:,1)=fft2(pad_motion_kernel);   %fourier trasnform the motion lernel
motion_pic_fft(:,:,1)=fft2(motion_pic(:,:,1));      %fourier trasnform the red part               
motion_pic_fft(:,:,2)=fft2(motion_pic(:,:,2));      %fourier trasnform the green part   
motion_pic_fft(:,:,3)=fft2(motion_pic(:,:,3));      %fourier trasnform the blue part     

RGB_scale=255*1e-19;
orignal_pic_fft(:,:,1) =motion_pic_fft(:,:,1) ./(motion_kernel_fft+RGB_scale);
%getting the orignal red part
orignal_pic_fft(:,:,2) =motion_pic_fft(:,:,2) ./(motion_kernel_fft+RGB_scale);
%getting the orignal green part
orignal_pic_fft(:,:,3) =motion_pic_fft(:,:,3) ./(motion_kernel_fft+RGB_scale);
%getting the orignal blue part

orignal_pic=255*ifft2(orignal_pic_fft);     %inverse fourier transform
show_images(motion_pic(floor(19/2):row-floor(19/2),floor(19/2):column-floor(19/2),:),uint16(orignal_pic(19:row-19,19:column-19,:)),"Motion","Orignal");              
%show the motion and orignal picture
imwrite(uint16(orignal_pic(1:row-19,1:column-19,:)),"image5.png");  
%save the orignal picture and we reduce the frame

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

function  show_colors(pici) %picture input
%SHOW_COLORS Summary of this function goes here
%it shows all colors possible of the input picture
%   Detailed explanation goes here
    figure();                   %opens a figure
    subplot(3,3,1);             %divide the figure into 9 pieces
    imshow(pici);
    xlabel("Orignal");
    subplot(3,3,2);              %the second picture
    imshow(select_color(pici,1));%selects the red picture   
    xlabel("Red");
    subplot(3,3,3);              %the third picture
    imshow(select_color(pici,2));%selects the green picture   
    xlabel("Green");
    subplot(3,3,4);              %the fouth picture
    imshow(select_color(pici,3));%selects the blue picture   
    xlabel("Blue");
    subplot(3,3,5);              %the fifth picture
    imshow(select_color(pici,4));%selects the purple picture   
    xlabel("Purple");
    subplot(3,3,6);              %the sixth picture
    imshow(select_color(pici,5));%selects the cyan picture   
    xlabel("Cyan");
    subplot(3,3,7);              %the seventh picture
    imshow(select_color(pici,6));%selects the yellow picture   
    xlabel("Yellow");
    subplot(3,3,8);              %the eigth picture
    imshow(select_color(pici,7));%selects the grey picture   
    xlabel("Grey");
    subplot(3,3,9);              %the eigth picture
    imshow(select_color(pici,8));%selects the black and white picture   
    xlabel("Black and White");
end

function [O] = select_color(I,color) 
%the output is: "O" output picture 
%the input is: "I" the input picture and "color" the color selected
%any picture contains RGB red green blue part so we are going to use it to
%extract the colors components 
%("What color do you want?\n
%1:Red     2:Green     3:Blue      4:Purple    5:Cyan      6:Yellow  7:Grey   8:Black and White\n");
    switch color
       case 1 
            O=I;
            O(:,:,2:3)=0;
       case 2
            O=I;
            O(:,:,1:2:3)=0;          
       case 3
            O=I;
            O(:,:,1:2)=0;          
       case 4
            O=I;
            O(:,:,2)=0;          
       case 5
            O=I;
            O(:,:,1)=0;          
       case 6
            O=I;
            O(:,:,3)=0;           
        case 7
            O=rgb2gray(I);
        case 8
            O=im2bw(I);
        otherwise
            O=I;   
    end
end

