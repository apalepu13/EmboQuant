% column 1: time, column 2: pressure

clear; close all;

% data0 = xlsread('Data\22217-1.xls');
% data1 = xlsread('Data\22217-2.xls');
% data2 = xlsread('Data\22217-3.xls');
% data3 = xlsread('Data\22217-4.xls');
% data4 = xlsread('Data\22217-5.xls');
% data5 = xlsread('Data\22217-6.xls');
% data1(:,1) = data1(:,1) + data0(end,1);
% data2(:,1) = data2(:,1) + data1(end,1);
% data3(:,1) = data3(:,1) + data2(end,1);
% data4(:,1) = data4(:,1) + data3(end,1);
% data5(:,1) = data5(:,1) + data4(end,1);
% data = [data0; data1; data2; data3; data4; data5];
% 
% clear data0 data1 data2 data3 data4 data5
% save('data-22217.mat');

load('data-22217.mat');

data(:,1) = data(:,1) / 60;

window_size = 101;
half_size = floor(window_size/2);


windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

mean_per_stage = zeros(6,2);
% minutes
mean_per_stage(1,:) = [2.5 mean(windowed_data(1:6070,2))];
mean_per_stage(2,:) = [6.5 mean(windowed_data(7450:11950,2))];
mean_per_stage(3,:) = [10 mean(windowed_data(13450:18700,2))];
mean_per_stage(4,:) = [13.8 mean(windowed_data(19450:21250,2))];
mean_per_stage(5,:) = [16 mean(windowed_data(22450:24700,2))];
mean_per_stage(6,:) = [19 mean(windowed_data(27700:29050,2))];

mean_diff = zeros(5,1);
for i = 1:5
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end
vasculature_flow = [38.33 34 32.33 30 29 28];

subplot(3,1,1)
plot(windowed_data(:,1), windowed_data(:,2), 'b')
title('Windowed Pressure Profile 2.22.17')
xlabel('Time (min)')
ylabel('Pressure (mmHg)')
xlim([0 20])
ylim([750 950])
hold on
plot(mean_per_stage(:,1), mean_per_stage(:,2), 'rx');
subplot(3,1,2)
plot(2:2:10, mean_diff,'g*')
xlim([0, 12])
ylim([0, 35])
title('Pressure Difference per Embolization Stage')
xlabel('Amount of Beads (mL)')
ylabel('Differential Pressure (mmHg)')
subplot(3,1,3)
Fit = polyfit(vasculature_flow',mean_per_stage(:,2),1);
plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
hold on
text(37.5, 850, sprintf('y = %.2fx + %.2f', Fit), 'HorizontalAlignment', 'center');
plot(vasculature_flow, mean_per_stage(:,2), 'ro');
title('Pressure vs Flow')
xlabel('Flow (mL/5 seconds)')
ylabel('Pressure (mmHg)')
ax = gca;
ax.XTick = 26:40;
ax.YTick = 750:25:900;
xlim([26, 40])
ylim([750, 900])
SS_reg = sum((polyval(Fit,vasculature_flow) - mean_per_stage(:,2)').^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(37.5, 865, ['R^{2} = '  num2str(rsquared)], 'HorizontalAlignment', 'center');