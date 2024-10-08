% Read the image
Image = imread('test1.jpg');

% seperate red, green, and blue color components
redComponent = Image(:,:,1);
greenComponent = Image(:,:,2);
blueComponent = Image(:,:,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Task 1 Part B4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the motion blur kernel
motionKernel = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1] / (20 * 256);

% Perform 2D convolution with the motion blur kernel for each color component
motionRed = conv2(double(redComponent), motionKernel);
motionGreen = conv2(double(greenComponent), motionKernel);
motionBlue = conv2(double(blueComponent), motionKernel);

% Combine the motion-blurred color components
motionBlurred = cat(3, uint8(motionRed), uint8(motionGreen), uint8(motionBlue));

% Display the motion-blurred image
figure(5);
subplot(1, 1, 1);
imshow(motionBlurred);
title('Motion Blurred Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%  Task 1 Part C  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Compute the Fourier transform of the motion-blurred RGB components
fftMotionred = fft2(double(motionRed)) / 256;
fftMotiongreen = fft2(double(motionGreen)) / 256;
fftMotionblue = fft2(double(motionBlue)) / 256;

% Compute the Fourier transform of the motion blur kernel with appropriate size
fftMotionKernel = fft2(motionKernel, size(motionBlurred, 1), size(motionBlurred, 2));

% Set the regularization parameter
ep = 0.145;

% Frequency domain restoration: Divide the Fourier transform of the motion-blurred components by the Fourier transform of the kernel
fftRed = fftMotionred ./ (fftMotionKernel * 256 + ep);
fftGreen = fftMotiongreen ./ (fftMotionKernel * 256 + ep);
fftBlue = fftMotionblue ./ (fftMotionKernel * 256 + ep);

% Inverse Fourier transform to obtain the restored RGB components
RestoredRed = ifft2(fftRed);
RestoredGreen = ifft2(fftGreen);
RestoredBlue = ifft2(fftBlue);

% Combine the restored color components to get the restored image
RestoredImage = cat(3, (RestoredRed), (RestoredGreen), (RestoredBlue));

% Display the restored image
figure;
imshow(RestoredImage);
title('The Restored Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%