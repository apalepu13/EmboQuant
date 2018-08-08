%%% *Pressure vs. Degree of Embolization Analysis*

%%
% *Initialize*

clear; close all; clc

%%
% *Setup (only run once)*

% Read in data from excel sheet
data1 = xlsread('Data\4217-1.xls');
data2 = xlsread('Data\4217-2.xls');
data3 = xlsread('Data\4217-3.xls');
data4 = xlsread('Data\4217-4.xls');
data5 = xlsread('Data\4217-5.xls');

% Combine time dimension for separate files
data2(:,1) = data2(:,1) + data1(end,1);
data3(:,1) = data3(:,1) + data2(end,1);
data4(:,1) = data4(:,1) + data3(end,1);
data5(:,1) = data5(:,1) + data4(end,1);

% Concatenate all data into one matrix
data = [data1; data2; data3; data4; data5];

% Save data to file for easy access
save('data-4217.mat');

%%
% *Load data*

load('data-4217.mat');

%%
% *Data Analysis*

% DATA NOTE: column 1 - time, column 2 - pressure

% convert time from seconds to minutes
data(:,1) = data(:,1) / 60;

% downsample data to reduce computation time
% data = downsample(data,10,9);

% set sizes for the sliding mean filter
window_size = 101;
half_size = floor(window_size/2);

% apply mean filter to data to reduce noise
windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

% define vector for volume of beads injected
volBeads = 0:0.25:13.5;
volBeads = volBeads';

% specify the mean pressures of each stage of embolization
mean_per_stage = zeros(length(volBeads),2);
mean_per_stage(1,:) = [1.4 mean(windowed_data(1:3700,2))];
mean_per_stage(2,:) = [4.5 mean(windowed_data(4450:8200,2))];
mean_per_stage(3,:) = [7.9 mean(windowed_data(9548:13240,2))];
mean_per_stage(4,:) = [11.3 mean(windowed_data(14902:17990,2))];
mean_per_stage(5,:) = [13.5 mean(windowed_data(18655:22300,2))];
mean_per_stage(6,:) = [16.3 mean(windowed_data(23050:25750,2))];
mean_per_stage(7,:) = [18.9 mean(windowed_data(26695:29485,2))];
mean_per_stage(8,:) = [21.3 mean(windowed_data(30250:33040,2))];
mean_per_stage(9,:) = [23.7 mean(windowed_data(34825:37487,2))];
mean_per_stage(10,:) = [27 mean(windowed_data(38380:42595,2))];
mean_per_stage(11,:) = [30.2 mean(windowed_data(43195:48130,2))];
mean_per_stage(12,:) = [33.5 mean(windowed_data(48850:51805,2))];
mean_per_stage(13,:) = [36.4 mean(windowed_data(52825:56590,2))];
mean_per_stage(14,:) = [39.4 mean(windowed_data(57430:60715,2))];
mean_per_stage(15,:) = [42.5 mean(windowed_data(62005:65215,2))];
mean_per_stage(16,:) = [45.5 mean(windowed_data(66520:70990,2))];
mean_per_stage(17,:) = [49.5 mean(windowed_data(71755:76225,2))];
mean_per_stage(18,:) = [52.5 mean(windowed_data(76817:80125,2))];
mean_per_stage(19,:) = [55 mean(windowed_data(80950:84220,2))];
mean_per_stage(20,:) = [57.5 mean(windowed_data(84775:88255,2))];
mean_per_stage(21,:) = [60.25 mean(windowed_data(89200:91495,2))];
mean_per_stage(22,:) = [62.5 mean(windowed_data(92500:95305,2))];
mean_per_stage(23,:) = [65.25 mean(windowed_data(95980:99685,2))];
mean_per_stage(24,:) = [68 mean(windowed_data(100450:103570,2))];
mean_per_stage(25,:) = [70.5 mean(windowed_data(104200:107200,2))];
mean_per_stage(26,:) = [72.75 mean(windowed_data(107830:111355,2))];
mean_per_stage(27,:) = [75.75 mean(windowed_data(112375:114850,2))];
mean_per_stage(28,:) = [78.25 mean(windowed_data(115555:119410,2))];
mean_per_stage(29,:) = [81.25 mean(windowed_data(119950:123955,2))];
mean_per_stage(30,:) = [84 mean(windowed_data(124810:127405,2))];
mean_per_stage(31,:) = [87.1 mean(windowed_data(128350:132955,2))];
mean_per_stage(32,:) = [90.6 mean(windowed_data(133600:138100,2))];
mean_per_stage(33,:) = [94.25 mean(windowed_data(138565:145345,2))];
mean_per_stage(34,:) = [98.75 mean(windowed_data(146155:149950,2))];
mean_per_stage(35,:) = [101.5 mean(windowed_data(150550:154750,2))];
mean_per_stage(36,:) = [104.25 mean(windowed_data(155350:157750,2))];
mean_per_stage(37,:) = [107 mean(windowed_data(158500:162100,2))];
mean_per_stage(38,:) = [109.3 mean(windowed_data(162850:165250,2))];
mean_per_stage(39,:) = [111.2 mean(windowed_data(165850:167650,2))];
mean_per_stage(40,:) = [112.7 mean(windowed_data(168250:169750,2))];
mean_per_stage(41,:) = [114 mean(windowed_data(170350:171550,2))];
mean_per_stage(42,:) = [115.5 mean(windowed_data(172150:173950,2))];
mean_per_stage(43,:) = [117 mean(windowed_data(174700:175900,2))];
mean_per_stage(44,:) = [118.3 mean(windowed_data(176500:178150,2))];
mean_per_stage(45,:) = [120.5 mean(windowed_data(178900:182500,2))];
mean_per_stage(46,:) = [123 mean(windowed_data(183400:185350,2))];
mean_per_stage(47,:) = [126 mean(windowed_data(185800:191650,2))];
mean_per_stage(48,:) = [131.5 mean(windowed_data(192550:202300,2))];
mean_per_stage(49,:) = [137.25 mean(windowed_data(203950:207850,2))];
mean_per_stage(50,:) = [140 mean(windowed_data(208600:211000,2))];
mean_per_stage(51,:) = [142.2 mean(windowed_data(211900:214600,2))];
mean_per_stage(52,:) = [144.25 mean(windowed_data(215200:217450,2))];
mean_per_stage(53,:) = [146.25 mean(windowed_data(218350:220600,2))];
mean_per_stage(54,:) = [148 mean(windowed_data(221050:222850,2))];
mean_per_stage(55,:) = [149.5 mean(windowed_data(223450:225100,2))];

% calculate difference between mean pressures of each stage of embolization
mean_diff = zeros(length(volBeads)-1,1);
for i = 1:length(mean_diff)
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end

% input vasculature flow values from experimental data
vasculature_flow = [79 77 77.67 77 75 75.67 75 74 73.67 73.33 72 71 ...
    71 69.33 70 68.33 67.67 67.67 68 65.67 65 64 62.33 59.67 58.33 ...
    57.33 55.67 55 53 53.33 52 50.67 49 47 47 45.33 45 44 43 43 42 ...
    41.67 41.67 39.67 37.67 37.67 37 36.33 36.33 35.67 34.67 35.67 ...
    34.67 34.67 34.33];


%%
% *Plotting*

figure;

subplot(3,1,1)
% Plot mean-filtered time series pressure data
plot(windowed_data(:,1), windowed_data(:,2), 'b')
title('Windowed Pressure Profile 4.2.17')
ax = gca;
ax.XTick = 0:10:150;
ax.YTick = 820:10:860;
xlabel('Time (min)')
ylabel('Pressure (mmHg)')
xlim([0 152])
ylim([820 860])
hold on
% Indicate mean pressures per embolization stage on the same plot
plot(mean_per_stage(:,1), mean_per_stage(:,2), 'rx');

subplot(3,1,2)

% Plot mean pressures against amount of beads injected (analogous to
% embolization stage)
plot(volBeads, mean_per_stage(:,2),'g*')
hold on
% Fit/plot a logistic curve to mean pressure per embolization stage data
[Qpre, p, sm, varcov] = fit_logistic(mean_per_stage(:,1), ...
    mean_per_stage(:,2)-mean_per_stage(1,2));
plot(volBeads, Qpre+mean_per_stage(1,2))
ax = gca;
ax.XTick = 0:14;
ax.YTick = 820:10:860;
xlim([0 14])
ylim([820 860])
title('Average Pressure per Embolization Stage')
xlabel('Amount of Beads (mL)')
ylabel('Pressure (mmHg)')
% Calculate/indicate r-squared between logistic curve and data on plot
SS_reg = sum((Qpre - mean_per_stage(:,2) + mean_per_stage(1,2)).^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(13, 830, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'right');
text(13, 834, ['Plateau Value: ' num2str(p(2)+mean_per_stage(1,2))], ...
    'HorizontalAlignment', 'right');

subplot(3,1,3)
% Fit/plot vasculature flow vs. mean pressure
Fit = polyfit(vasculature_flow',mean_per_stage(:,2),1);
plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
hold on
text(77.5, 850, sprintf('y = %.2fx + %.2f', Fit), ...
    'HorizontalAlignment', 'right');
plot(vasculature_flow, mean_per_stage(:,2), 'ro');
title('Pressure vs Flow')
xlabel('Vasculature Flow (mL/5 seconds)')
ylabel('Pressure (mmHg)')
% Calculate/indicate r-squared between linear curve and data on plot
SS_reg = sum((polyval(Fit,vasculature_flow) - mean_per_stage(:,2)').^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(77.5, 846.5, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'right');
