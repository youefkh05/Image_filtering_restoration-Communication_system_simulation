clear;
clc;
load filters;   %loading filters
%section A %%%%%%%
%get the first input
[file1,path1]=uigetfile('*.*');  %The file locatioon
mp1=strcat(path1,file1);         %The file path
[Ai1 ,fi1]=audioread(mp1);       %Read the file
om1=audioplayer(Ai1,fi1);    %make orignal audio object

%get the seond input
[file2,path2]=uigetfile('*.*');  %The file locatioon
mp2=strcat(path2,file2);         %The file path
[Ai2 ,fi2]=audioread(mp2);       %Read the file
om2=audioplayer(Ai2,fi2);    %make orignal audio object

Ai1=low_filter(Ai1,fi1,1,low_pass);
Ai2=low_filter(Ai2,fi2,2,low_pass);
fm1=audioplayer(Ai1,fi1);   %make filter audio object
fm2=audioplayer(Ai2,fi2);   %make filter audio object
%{
disp("first input");
play(om1);               %play orignal audio                  
pause(10);              %it plays it for 10 seconds
stop(om1);               %stop orignal audio
disp("first input filtered");
play(fm1);               %play orignal audio
pause(10);              %it plays it for 10 seconds
stop(fm1);               %stop orignal audio 
disp("second input");
play(om2);               %play orignal audio                  
pause(10);              %it plays it for 10 seconds
stop(om2);               %stop orignal audio
disp("second input filtered");
play(fm2);               %play orignal audio
pause(10);              %it plays it for 10 seconds
stop(fm2);               %stop orignal audio 
audiowrite("output1filter.wav",Ai1,fi1); %save the filtered file
audiowrite("output2filter.wav",Ai2,fi2); %save the filtered file
%%%%%%%%%
%}
%section B %%%%%%%%
% first we will get the carrier signal in frequincy domain
Ai1=Ai1(:,1);               %make it mono
Ai2=Ai2(:,1);               %make it mono
A=1;                        %Carry amplitude
Fs=41000;                   %Sample frequency
fc1=5500;                   %Carry frequency
fc2=14000;                  %Carry frequency
Ts=1/Fs;                    %Sample period
N=length(Ai1);              %Number of samples
t=[0:Ts:N*Ts-Ts];           %Time vector
f=[-Fs/2:Fs/N:Fs/2-Fs/N];   %Frequency vector 
x1=A*cos(2*pi*fc1*t);       %Carry

%second carrier signal
x2=A*cos(2*pi*fc2*t);

%Carry graph
figure();                   %opens a figure
subplot(2,2,1);             %divide it into half and plot the first half
plot(t,x1,'r');             %plot carry in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Carry1 Wave Graph",'FontSize',18);

subplot(2,2,2);             %divide it into half and plot the first half
plot(t,x2,'r');             %plot carry in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Carry2 Wave Graph",'FontSize',18);

subplot(2,1,2);                  %second half
xft=fft(x1)+fft(x2);             %Fourier transform
plot(f,fftshift(abs(xft)),'r');  %plot carry in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);

%Input1 graph
figure();                      %opens a figure
subplot(2,1,1);                %divide it into half and plot the first half
plot(t,Ai1,'g');               %plot input in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Message1 before filter Wave Graph",'FontSize',18);
subplot(2,1,2);                %second half
Ai1_fft=fft(Ai1);              %Fourier transform
plot(f,fftshift(Ai1_fft),'g'); %plot input in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);

%Input2 graph
figure();                      %opens a figure
subplot(2,1,1);                %divide it into half and plot the first half
plot(t,Ai2,'g');               %plot input in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Message2 Wave before filter Graph",'FontSize',18);
subplot(2,1,2);                %second half
Ai2_fft=fft(Ai2);              %Fourier transform
plot(f,fftshift(Ai2_fft),'g'); %plot input in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
%%%%%%%%%%%%%%%%%

%secion C %%%%%%%%%%%%%%%%%
%Modulate
Ym=transpose(x1).*Ai1+transpose(x2).*Ai2;         
figure();                    %opens a figure
subplot(2,1,1);              %divide it into half and plot the first half
plot(t,Ym,'b');              %plot modulated siganl in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Modulated Wave Graph",'FontSize',18);
subplot(2,1,2);              %second half
Ym_fft=fft(Ym);              %Fourier transform
plot(f,fftshift(Ym_fft),'b');%plot modulated siganl in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
%%%%%%%%%%%%%%%%%

%section D %%%%%%%%%%%%%%%%%
%select which chanel
ch=0;
while ch ~=1 && ch~=2
ch=input("Which channel do you want?\n 1 or 2\n");
if ch ~=1 && ch~=2
disp("Invalid input");
end
end

%Channel selection
if ch==1
xs=x1;
As=Ai1;
fsel=fi1;
outname="1";
Hds=band_pass1;
filter_coef=4;
else if ch==2
        xs=x2;
        As=Ai2;
        fsel=fi2;
        outname="2";
        Hds=band_pass2;
        filter_coef=2;
    end
end
%%%%%%%%%%%%%%%%%

%section E %%%%%%%%%%%%%%%%%
%demultiplexing
Ydemux=filter(Hds,Ym);
figure();                    %opens a figure
subplot(2,1,1);              %divide it into half and plot the first half
plot(t,Ydemux,'c');              %plot modulated siganl in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Demuxed Wave Graph",'FontSize',18);
subplot(2,1,2);              %second half
Ydemux_fft=fft(Ydemux);              %Fourier transform
plot(f,fftshift(Ydemux_fft),'c');%plot modulated siganl in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
%%%%%%%%%%%%%%%%%

%section F %%%%%%%%%%%%%%%%%
Yd=Ydemux.*transpose(xs);         
figure();                       %opens a figure               
subplot(2,1,1);                 %divide it into half and plot the first half
plot(t,Yd,'k');                 %plot demodulated siganl in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Demodulated Wave Graph",'FontSize',18);
subplot(2,1,2);                 %second half
Yd_fft=fft(Yd);                 %Fourier transform
plot(f,fftshift(Yd_fft),'k');   %plot demodulated siganl in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
%%%%%%%%%%%%%%%%%

%section H %%%%%%%%%%%%%%%%%
% filter with gain 2
Yf=filter_coef*filter(low_pass,Yd);    
figure();                       %opens a figure
subplot(2,1,1);                 %divide it into half and plot the first half
plot(t,Yf,'m');                 %plot filtered siganl in time domain
xlabel("Time",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
title("Filtered Wave Graph",'FontSize',18);
subplot(2,1,2);                 %second half
Yr_fft=fft(Yf);                 %Fourier transform
plot(f,fftshift(Yr_fft),'m');   %plot demodulated siganl in frequency domain
xlabel("Frequency",'FontSize',10);  
ylabel("Amplitude",'FontSize',10);
%%%%%%%%%%%%%%%%%

%section K %%%%%%%%%%%%%%%%%
%let everthing stereo
xs=transpose(xs);
xs(:,2)=xs(:,1);
As(:,2)=As(:,1);
Ym(:,2)=Ym(:,1);
Yd(:,2)=Yd(:,1);
Yf(:,2)=Yf(:,1);

%{
%listen to eveything
cm=audioplayer(xs,fsel);
im=audioplayer(As,fsel);
mm=audioplayer(Ym,fsel);
dmux=audioplayer(Ydemux,fsel);
dm=audioplayer(Yd,fsel);
fm=audioplayer(Yf,fsel);
disp("Carry");
%play(cm); %Warning
%pause(11);
disp("Input");
play(im);
pause(11);
disp("Modulate");
play(mm);
pause(11);
disp("Demux");
play(dmux);
pause(11);
disp("Demodulate");
play(dm);
pause(11);
disp("Filtered");
play(fm);
pause(11);
%%%%%%%%%%%%%%%%%
%}
%section Q %%%%%%%%%%%%%%%%%
%save the file
audiowrite("carry.wav",x1+x2,fsel);
audiowrite("modulate.wav",Ym,fsel);
audiowrite("demodulate.wav",Yd,fsel);
audiowrite("output"+outname+".wav",Yf,fsel);
%%%%%%%%%%%%%%%%%


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

function record_myvoice(Fs,Nseconds,input_num)
%RECORD Summary of this function goes here
%   Detailed explanation goes here
warning off
ch=2;           %Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits=16;       %8,16,or 24

                % to record audio data from an input device ...
...such as a microphone for processing in MATLAB
recorder=audiorecorder(Fs,nbits,ch);
disp('Start speaking..')
%Record audio to audiorecorder object,...
...hold control until recording completes
recordblocking(recorder,Nseconds);
disp('End of Recording.');
%Store recorded audio signal in numeric array
x=getaudiodata(recorder);
%Write audio file
audiowrite("input"+int2str(input_num)+".wav",x,Fs);
end

