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

