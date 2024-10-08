clear;
clc;
load filters

[file,path]=uigetfile('*.*'); %get the file 
mp=strcat(path,file);    %concatonate the file name and path
[oy ,fs]=audioread(mp);  %read the audio
of=filter(low_pass,oy);        %filter the audio

figure();       %opens a figure
N=length(oy);   %get the amplitude length
k=0:N-1;        %calculating k
OF=fft(of,N);   %frequency shift the orignal
OY=fft(oy,N);   %frequency shift the filter
subplot(1,2,1); %divide it into half and choose the first half
plot(k,abs(OY));%draw the orignal audio
subplot(1,2,2); %second half
plot(k,abs(OF));%draw the filter audio
pause(3);       %wait 3 seconds

figure();           %opens a figure
F=(0:N-1)*fs/N;     %calculate the frequency to plot it
subplot(1,2,1);     %divide it into half and choose the first half
plot(F,abs(oy)/N);  %draw the orignal audio
subplot(1,2,2);     %second half
plot(F,abs(of)/N);  %draw the filter audio
pause(3);           %wait 3 seconds

    
figure();                   %opens a figure  
F=(-N/2:N/2-1)*fs/N;        %center the frequency to plot it
subplot(1,2,1);             %divide it into half and choose the first half
plot(F,abs(fftshift(oy))/N);%draw the orignal audio
subplot(1,2,2);             %second half
plot(F,abs(fftshift(of))/N);%draw the filter audio

om=audioplayer(oy,fs);   %make orignal audio object
fm=audioplayer(of,fs);   %make filter audio object
play(om);   %play orignal audio                  
pause(10);  %it plays it for 10 seconds
stop(om);   %stop orignal audio
play(fm);   %play orignal audio
pause(10);  %it plays it for 10 seconds
stop(fm);   %stop orignal audio 

audiowrite("output1filter.wav",of,fs); %save the filtered file