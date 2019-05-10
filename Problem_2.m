leftImage = imread('viewL.png');
rightImage = imread('viewR.png');


disp_map1 = compute_corrs(rightImage,leftImage,'SSD');
disp_map2 = compute_corrs(rightImage,leftImage,'CC');
disp_map3 = compute_corrs(rightImage,leftImage,'NCC');

load('disparity.mat');

error1 = (double(L) - disp_map1)/double(L);
error2 = (double(L) - disp_map2)/double(L);
error3 = (double(L) - disp_map3)/double(L);

figure;imagesc(disp_map1);
colormap(jet);
axis image;

figure;imagesc(disp_map2);
colormap(jet);
axis image;
figure;imagesc(disp_map3);
colormap(jet);
axis image;

mean_error = mean(error1);
max_error = max(error1);
min_error = min(error1);
std_error = std(error1);
disp('SSD');
disp('mean_error');
disp(mean_error);
disp('max_error');
disp(max_error);
disp('min_error');
disp(min_error);
disp('std_error');
disp(std_error);

mean_error = mean(error2);
max_error = max(error2);
min_error = min(error2);
std_error = std(error2);
disp('CC');
disp('mean_error');
disp(mean_error);
disp('max_error');
disp(max_error);
disp('min_error');
disp(min_error);
disp('std_error');
disp(std_error);

mean_error = mean(error3);
max_error = max(error3);
min_error = min(error3);
std_error = std(error3);

disp('NCC');
disp('mean_error');
disp(mean_error);
disp('max_error');
disp(max_error);
disp('min_error');
disp(min_error);
disp('std_error');
disp(std_error);