% column 1: time, column 2: pressure

clear; close all;

% data1 = xlsread('Data\3317-1.xls');
% data2 = xlsread('Data\3317-2.xls');
% data3 = xlsread('Data\3317-3.xls');
% data2(:,1) = data2(:,1) + data1(end,1);
% data3(:,1) = data3(:,1) + data2(end,1);
% data = [data1; data2; data3];
% save('data-3317.mat');

load('data-3317.mat');

data(:,1) = data(:,1) / 60;

window_size = 101;
half_size = floor(window_size/2);

windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

mean_per_stage = zeros(12,2);
% minutes
mean_per_stage(1,:) = [2.5 mean(windowed_data(1:7450,2))];
mean_per_stage(2,:) = [10 mean(windowed_data(8950:17950,2))];
mean_per_stage(3,:) = [16 mean(windowed_data(19450:28450,2))];
mean_per_stage(4,:) = [23 mean(windowed_data(29950:38200,2))];
mean_per_stage(5,:) = [33 mean(windowed_data(40450:59700,2))];
mean_per_stage(6,:) = [45 mean(windowed_data(61450:70450,2))];
mean_per_stage(7,:) = [51 mean(windowed_data(73450:80950,2))];
mean_per_stage(8,:) = [57.5 mean(windowed_data(82450:88450,2))];
mean_per_stage(9,:) = [63.5 mean(windowed_data(91450:98950,2))];
mean_per_stage(10,:) = [70 mean(windowed_data(100450:110950,2))];
mean_per_stage(11,:) = [77.5 mean(windowed_data(112450:118450,2))];
mean_per_stage(12,:) = [82.5 mean(windowed_data(121450:end,2))];

mean_diff = zeros(11,1);
for i = 1:length(mean_diff)
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end
vasculature_flow = [65.67 60 58.67 56.67 55 50.67 47 45.67 38.67 34 29.33 24.33];

figure;
subplot(3,1,1)
plot(windowed_data(:,1), windowed_data(:,2), 'b')
title('Windowed Pressure Profile 3.3.17')
ax = gca;
ax.XTick = 0:5:85;
ax.YTick = 900:50:1100;
xlabel('Time (min)')
ylabel('Pressure (mmHg)')
xlim([0 85])
ylim([850 1150])
hold on
plot(mean_per_stage(:,1), mean_per_stage(:,2), 'rx');
subplot(3,1,2)
plot(1:11, mean_diff,'g*')
xlim([0, 12])
ylim([0, 50])
title('Pressure Difference per Embolization Stage')
xlabel('Amount of Beads (mL)')
ylabel('Differential Pressure (mmHg)')
subplot(3,1,3)
Fit = polyfit(vasculature_flow',mean_per_stage(:,2),1);
plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
hold on
text(60, 1025, sprintf('y = %.2fx + %.2f', Fit), ...
    'HorizontalAlignment', 'center');
plot(vasculature_flow, mean_per_stage(:,2), 'ro');
title('Pressure vs Flow')
ax = gca;
ax.YTick = 800:50:1100;
xlabel('Vasculature Flow (mL/5 seconds)')
ylabel('Pressure (mmHg)')
SS_reg = sum((polyval(Fit,vasculature_flow) - mean_per_stage(:,2)').^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(60, 1050, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'center');