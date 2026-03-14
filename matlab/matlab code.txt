clc;
clear;
close all;

%% Read Image
img = imread('leaf.jpg');   % Make sure filename matches
figure;
imshow(img);
title('Original Image');

%% Convert to Grayscale (Important for FPGA memory saving)
if size(img,3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

figure;
imshow(img_gray);
title('Grayscale Image');

%% Resize Image (IMPORTANT for Vivado Block RAM)
% Change size if needed
img_small = imresize(img_gray, [64 64]); 
img_vector = img_small(:);   % Convert 64x64 → 4096x1

figure;
imshow(img_small);
title('Resized Image (64x64)');

%% Convert to 1D Vector
img_vector = img_small(:);

%% Convert to 8-bit Binary
binary_data = dec2bin(img_vector, 8);

%% Write to .mem file
fid = fopen('leaf.mem', 'w');

for i = 1:size(binary_data,1)
    fprintf(fid, '%s\n', binary_data(i,:));
end

fclose(fid);

disp('leaf2.mem file generated successfully!');
binary_data = dec2bin(img_vector, 8);
fid = fopen('leaf.mem', 'w');

for i = 1:size(binary_data,1)
    fprintf(fid, '%s\n', binary_data(i,:));
end

fclose(fid);

disp('leaf.mem file generated successfully!');