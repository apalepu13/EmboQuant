%%% *Pressure vs. Degree of Embolization Analysis*

%%
% *Initialize*

clear; close all; clc

%%
% % *Setup (only run once)*
% 
% % Read in data from excel sheet and downsample to reduce computation time
% data1 = xlsread('Data\42817-1.xls');
% data1 = downsample(data1,10,9);
% data2 = xlsread('Data\42817-2.xls');
% data2 = downsample(data2,10,9);
% data3 = xlsread('Data\42817-3.xls');
% data3 = downsample(data3,10,9);
% 
% % Combine time dimension for separate files
% data2(:,1) = data2(:,1) + data1(end,1);
% data3(:,1) = data3(:,1) + data2(end,1);
% 
% % Concatenate all data into one matrix
% data = [data1; data2; data3];
% 
% data = downsample(data,10,9);
% 
% % Clear unnecessary variables
% clear data1 data2 data3
% 
% % Save data to file for easy access
% save('data-42817.mat');

%%
% *Load data*

load('data-42817.mat');

%%
% *Data Analysis*

% DATA NOTE: column 1 - time, column 2 - pressure

% convert time from seconds to minutes
data(:,1) = data(:,1) / 60;

% set sizes for the sliding mean filter
window_size = 11;
half_size = floor(window_size/2);

% apply mean filter to data to reduce noise
windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

% define vector for volume of beads injected
volBeads = 0.5:0.5:25;
volBeads = volBeads';

% specify the mean pressures of each stage of embolization
mean_per_stage = zeros(length(volBeads),2);
mean_per_stage(1,:) = [1 mean(windowed_data(1:3034,2))];
mean_per_stage(2,:) = [3 mean(windowed_data(3427:5423,2))];
mean_per_stage(3,:) = [4.7 mean(windowed_data(5664:7588,2))];
mean_per_stage(4,:) = [6 mean(windowed_data(7960:10174,2))];
mean_per_stage(5,:) = [7.7 mean(windowed_data(10357:12076,2))];
mean_per_stage(6,:) = [8.7 mean(windowed_data(12316:13831,2))];
mean_per_stage(7,:) = [10 mean(windowed_data(14113:15610,2))];
mean_per_stage(8,:) = [11 mean(windowed_data(16180:17065,2))];
mean_per_stage(9,:) = [12.2 mean(windowed_data(17665:19273,2))];
mean_per_stage(10,:) = [13.7 mean(windowed_data(19525:21136,2))];
mean_per_stage(11,:) = [15.5 mean(windowed_data(21400:24970,2))];
mean_per_stage(12,:) = [17.5 mean(windowed_data(25180:27325,2))];
mean_per_stage(13,:) = [19.5 mean(windowed_data(28000:29785,2))];
mean_per_stage(14,:) = [20.5 mean(windowed_data(30040:31795,2))];
mean_per_stage(15,:) = [22 mean(windowed_data(32080:33925,2))];
mean_per_stage(16,:) = [23.5 mean(windowed_data(34225:36085,2))];
mean_per_stage(17,:) = [24.8 mean(windowed_data(36250:38005,2))];
mean_per_stage(18,:) = [26 mean(windowed_data(38335:39610,2))];
mean_per_stage(19,:) = [27 mean(windowed_data(39865:41200,2))];
mean_per_stage(20,:) = [28.5 mean(windowed_data(41605:43960,2))];
mean_per_stage(21,:) = [30 mean(windowed_data(44275:45565,2))];
mean_per_stage(22,:) = [31.2 mean(windowed_data(45835:47410,2))];
mean_per_stage(23,:) = [32.5 mean(windowed_data(47830:49855,2))];
mean_per_stage(24,:) = [34.3 mean(windowed_data(50155:52690,2))];
mean_per_stage(25,:) = [36 mean(windowed_data(52975:55015,2))];
mean_per_stage(26,:) = [37.5 mean(windowed_data(55600:56845,2))];
mean_per_stage(27,:) = [39.1 mean(windowed_data(57250:59905,2))];
mean_per_stage(28,:) = [40.8 mean(windowed_data(60430:62245,2))];
mean_per_stage(29,:) = [42.3 mean(windowed_data(62635:64405,2))];
mean_per_stage(30,:) = [44.1 mean(windowed_data(64690:67825,2))];
mean_per_stage(31,:) = [46.2 mean(windowed_data(68305:70285,2))];
mean_per_stage(32,:) = [47.5 mean(windowed_data(70585:71905,2))];
mean_per_stage(33,:) = [48.7 mean(windowed_data(72190:73810,2))];
mean_per_stage(34,:) = [50 mean(windowed_data(74140:75685,2))];
mean_per_stage(35,:) = [51.25 mean(windowed_data(76015:77635,2))];
mean_per_stage(36,:) = [53 mean(windowed_data(77845:80815,2))];
mean_per_stage(37,:) = [54.5 mean(windowed_data(81115:82525,2))];
mean_per_stage(38,:) = [55.65 mean(windowed_data(82780:83995,2))];
mean_per_stage(39,:) = [58.35 mean(windowed_data(84190:90055,2))];
mean_per_stage(40,:) = [61 mean(windowed_data(90400:92470,2))];
mean_per_stage(41,:) = [62.4 mean(windowed_data(92770:94300,2))];
mean_per_stage(42,:) = [63.5 mean(windowed_data(94600:95905,2))];
mean_per_stage(43,:) = [64.5 mean(windowed_data(96160:97480,2))];
mean_per_stage(44,:) = [65.65 mean(windowed_data(97810:99040,2))];
mean_per_stage(45,:) = [66.5 mean(windowed_data(99400:99985,2))];
mean_per_stage(46,:) = [67.4 mean(windowed_data(100285:101875,2))];
mean_per_stage(47,:) = [68.9 mean(windowed_data(102205:104470,2))];
mean_per_stage(48,:) = [70.7 mean(windowed_data(104845:107035,2))];
mean_per_stage(49,:) = [72.6 mean(windowed_data(107410:110650,2))];
mean_per_stage(50,:) = [75 mean(windowed_data(110995:114325,2))];

% calculate difference between mean pressures of each stage of embolization
mean_diff = zeros(length(volBeads)-1,1);
for i = 1:length(mean_diff)
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end

% input vasculature flow values from experimental data
vasculature_flow = [79.33 78.67 77 76 73.67 70.33 68.67 66 63.33 62.33 ...
    58.67 57.67 57 53.67 53.33 50 48 45.67 44.67 43 43 40.33 38.67 37 ...
    35.67 34 32 29.67 27.33 24.67 22.67 20 18.33 16 13.67 12.33 11.67 ...
    10.33 10 10 9.67 9 8.67 8.67 8 8.33 8 8 7.67 8]';


%%
% *Plotting*


% figure;

subplot(2,2,1)

% Plot mean-filtered time series pressure data
plot(windowed_data(:,1), windowed_data(:,2), 'b')
ax = gca;
ax.XTick = 0:5:80;
ax.YTick = 820:10:860;
set(ax, 'FontSize', 13);
t = title('A. Real-Time Pressure Profile');
set(t, 'FontSize', 16);
xlabel('Time (min)')
ylabel('Pressure (mmHg)')
xlim([0 80])
ylim([820 860])
hold on
% Indicate mean pressures per embolization stage on the same plot
plot(mean_per_stage(:,1), mean_per_stage(:,2), 'rx');

% figure;
subplot(2,2,2)

% Plot mean pressures against amount of beads injected (analogous to
% embolization stage)
plot(volBeads, mean_per_stage(:,2),'g*')
hold on
% Fit/plot a logistic curve to mean pressure per embolization stage data
% [Qpre, p, sm, varcov] = fit_logistic(mean_per_stage(:,1), ...
%     mean_per_stage(:,2)-mean_per_stage(1,2));
% plot(volBeads, Qpre+mean_per_stage(1,2))
ax = gca;
ax.XTick = 0:2:26;
ax.YTick = 820:10:860;
set(ax, 'FontSize', 13);
t = title('B. Average Pressure per Embolization Stage');
set(t, 'FontSize', 16);
xlim([0 26])
ylim([820 860])
xlabel('Amount of Beads (mL)')
ylabel('Pressure (mmHg)')
% Calculate/indicate r-squared between logistic curve and data on plot
% SS_reg = sum((Qpre - mean_per_stage(:,2) + mean_per_stage(1,2)).^2);
% SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
% rsquared = 1 - SS_reg/SS_tot;
% text(25, 830, ['R^{2} = '  num2str(rsquared)], ...
%     'HorizontalAlignment', 'right');
% text(25, 834, ['Plateau Value: ' num2str(p(2)+mean_per_stage(1,2))], ...
%     'HorizontalAlignment', 'right');

% figure;
subplot(2,2,3)

% Plot mean pressures against amount of beads injected (analogous to
% embolization stage)
plot(volBeads, vasculature_flow,'g*')
hold on
% Fit/plot a logistic curve to mean pressure per embolization stage data
% [Qpre, p, sm, varcov] = fit_logistic(mean_per_stage(:,1), ...
%     mean_per_stage(:,2)-mean_per_stage(1,2));
% plot(volBeads, Qpre+mean_per_stage(1,2))
ax = gca;
ax.XTick = 0:2:26;
ax.YTick = 0:10:90;
set(ax, 'FontSize', 13);
t = title('C. Vasculature Flow per Embolization Stage');
set(t, 'FontSize', 16);
xlim([0 26])
ylim([0 90])
xlabel('Amount of Beads (mL)')
ylabel('Vasculature Flow (mL/5 seconds)')
% Calculate/indicate r-squared between logistic curve and data on plot
% SS_reg = sum((Qpre - mean_per_stage(:,2) + mean_per_stage(1,2)).^2);
% SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
% rsquared = 1 - SS_reg/SS_tot;
% text(25, 830, ['R^{2} = '  num2str(rsquared)], ...
%     'HorizontalAlignment', 'right');
% text(25, 834, ['Plateau Value: ' num2str(p(2)+mean_per_stage(1,2))], ...
%     'HorizontalAlignment', 'right');

subplot(2,2,4)

% Fit/plot vasculature flow squared vs. mean pressure
Fit = polyfit(vasculature_flow.^2,mean_per_stage(:,2),1);
plot(vasculature_flow.^2, polyval(Fit,vasculature_flow.^2), 'b');
hold on
plot(vasculature_flow.^2, mean_per_stage(:,2), 'ro');
ax = gca;
set(ax, 'FontSize', 13);
t = title('D. Pressure vs Squared Flow');
set(t, 'FontSize', 16);
xlabel('Vasculature Flow^{2} (mL/5 seconds)^{2}')
ylabel('Pressure (mmHg)')
% Calculate/indicate r-squared between linear curve and data on plot
SS_reg = sum((polyval(Fit,vasculature_flow.^2) - mean_per_stage(:,2)).^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
t = text(6500, 850, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'right');
set(t, 'FontSize', 12);
