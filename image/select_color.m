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

