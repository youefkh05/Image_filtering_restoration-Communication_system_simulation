
Image = imread('peppers.png');

redComponent = Image(:,:,1);
greenComponent = Image(:,:,2);
blueComponent = Image(:,:,3);

motionKernel = [1 1 1 1 1 1 1 1 1 1 1 1 1 1] / (15 * 256);
fftKernel = fft2(motionKernel, size(Image, 1), size(Image, 2));
fftred = fft2(double(redComponent)) ./ 256;
fftgreen = fft2(double(greenComponent)) ./ 256;
fftblue = fft2(double(blueComponent)) ./ 256;

fftRed = fftred .* fftKernel ;
fftGreen = fftgreen .* fftKernel ;
fftBlue = fftblue .* fftKernel ;

motionRed = ifft2(fftRed);
motionGreen = ifft2(fftGreen);
motionBlue = ifft2(fftBlue);

motionImage = cat(3, (motionRed), (motionGreen), (motionBlue));

figure(5);
subplot(1, 1, 1);
imshow(motionImage);
title('Motion Blurred Image');

fftMotionred = fft2(motionRed)/256;
fftMotiongreen = fft2(motionGreen)/256;
fftMotionblue = fft2(motionBlue)/256;

fftMotionKernel = fft2(motionKernel, size(motionImage, 1), size(motionImage, 2));
ep = 10^(-5);
fft_Red = fftMotionred ./ (fftMotionKernel*256 +ep);
fft_Green = fftMotiongreen ./ (fftMotionKernel*256 +ep);
fft_Blue = fftMotionblue ./ (fftMotionKernel*256 +ep );

RestoredRed = ifft2(fft_Red);
RestoredGreen = ifft2(fft_Green);
RestoredBlue = ifft2(fft_Blue);

RestoredImage = 255*cat(3, RestoredRed, RestoredGreen, RestoredBlue);

figure
imshow(RestoredImage);
title('The Restored Image');
