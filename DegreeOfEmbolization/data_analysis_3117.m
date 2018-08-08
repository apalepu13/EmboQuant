% column 1: time, column 2: pressure

clear; close all;

% data1 = xlsread('C:\Users\schen\OneDrive\Documents\Design Team 2016-2017\Experiments\Data\3117-1.xlsx');
% data1 = data1(:,2:3);
% data2 = xlsread('C:\Users\schen\OneDrive\Documents\Design Team 2016-2017\Experiments\Data\3117-2.xls');
% data2(:,1) = data2(:,1) + data1(end,1);
% data = [data1; data2];
% data = downsample(data, 10, 9);
% 
% clear data1 data2
% 
% save('C:\Users\schen\OneDrive\Documents\Design Team 2016-2017\Experiments\Data\data-3117.mat');

load('C:\Users\schen\OneDrive\Documents\Design Team 2016-2017\Experiments\Data\data-3117.mat');

data(:,1) = data(:,1) / 60;

window_size = 101;
half_size = floor(window_size/2);

windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

% NOTE: didn't do these indices yet
% mean_per_stage = zeros(6,2);
% % minutes
% mean_per_stage(1,:) = [2.5 mean(windowed_data(1:6070,2))];
% mean_per_stage(2,:) = [6.5 mean(windowed_data(7450:11950,2))];
% mean_per_stage(3,:) = [10 mean(windowed_data(13450:18700,2))];
% mean_per_stage(4,:) = [13.8 mean(windowed_data(19450:21250,2))];
% mean_per_stage(5,:) = [16 mean(windowed_data(22450:24700,2))];
% mean_per_stage(6,:) = [19 mean(windowed_data(27700:29050,2))];

mean_diff = zeros(5,1);
for i = 1:5
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end
vasculature_flow = [51.83 48.67 48 45 44.33 43 41 40 38.33 35 32.67 29.67 25.67 22.67];

% subplot(3,1,1)
plot(windowed_data(:,1), windowed_data(:,2))
title('Average Windowed Data')
xlabel('Time (min)')
ylabel('Pressure (mmHg)')
xlim([0 65])
ylim([850 1200])
% hold on
% plot(mean_per_stage(:,1), mean_per_stage(:,2), 'ro');
% subplot(3,1,2)
% plot([2,4,6,8,10], mean_diff,'o')
% xlim([0, 12])
% ylim([0, 35])
% title('Pressure Difference per Embolization Stage')
% xlabel('Amount of Beads (mL)')
% ylabel('Differential Pressure (mmHg)')
% subplot(3,1,3)
% Fit = polyfit(vasculature_flow',mean_per_stage(:,2),1);
% plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
% hold on
% plot(vasculature_flow, mean_per_stage(:,2), 'ro');
% title('Pressure vs Flow')
% xlabel('Flow (mL/5 seconds)')
% ylabel('Pressure (mmHg)')
