function [Af] = low_filter(A,f,input_num,low_pass_filter)
%LOW_FILTER Summary of this function goes here
%   Detailed explanation goes here
Af=filter(low_pass_filter,A);        %filter the audio


figure();       %opens a figure
N=length(A);   %get the amplitude length
k=0:N-1;        %calculating k
AF=fft(Af,N);   %frequency shift the orignal
AI=fft(A,N);   %frequency shift the filter
subplot(1,2,1); %divide it into half and choose the first half
plot(k,abs(AI));%draw the orignal audio
xlabel("K",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" before filter Wave Graph",'FontSize',18);
subplot(1,2,2); %second half
plot(k,abs(AF));%draw the filter audio
xlabel("K",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" after filter Wave Graph",'FontSize',18);
pause(3);       %wait 3 seconds

figure();           %opens a figure
F=(0:N-1)*f/N;     %calculate the frequency to plot it
subplot(1,2,1);     %divide it into half and choose the first half
plot(F,abs(A)/N);  %draw the orignal audio
xlabel("frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" before filter in frequncy domain",'FontSize',18);
subplot(1,2,2);     %second half
plot(F,abs(Af)/N);  %draw the filter audio
xlabel("frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" after filter in frequncy domain",'FontSize',18);
pause(3);           %wait 3 seconds

    
figure();                   %opens a figure  
subplot(1,2,1);             %divide it into half and choose the first half
plot(F,abs(fftshift(A))/N);%draw the orignal audio
xlabel("frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" before filter shifted frequency",'FontSize',18);
subplot(1,2,2);             %second half
plot(F,abs(fftshift(Af))/N);%draw the filter audio
xlabel("frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Input"+int2str(input_num)+" before filter shifted frequency",'FontSize',18);


end

