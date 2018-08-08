% column 1: time, column 2: pressure

clear; close all;

% data1 = xlsread('Data\4917-1.xls');
% data2 = xlsread('Data\4917-2.xls');
% data2(:,1) = data2(:,1) + data1(end,1);
% data = [data1; data2];
% clear data1 data2
% data3 = xlsread('Data\4917-3.xls');
% data3 = downsample(data3,10,9);
% data3(:,1) = data3(:,1) + data(end,1);
% data = [data; data3];
% clear data3
% data4 = xlsread('Data\4917-4.xls');
% data4 = downsample(data4,10,9);
% data4(:,1) = data4(:,1) + data(end,1);
% data = [data; data4];
% clear data4
% data5 = xlsread('Data\4917-5.xls');
% data5 = downsample(data5,10,9);
% data5(:,1) = data5(:,1) + data(end,1);
% data = [data; data5];
% clear data5
% data6 = xlsread('Data\4917-6.xls');
% data6 = downsample(data6,10,9);
% data6(:,1) = data6(:,1) + data(end,1);
% data = [data; data6];
% clear data6

load('data-4917.mat');

data(:,1) = data(:,1) / 60;

window_size = 101;
half_size = floor(window_size/2);

windowed_data = zeros(length(data)-window_size+1,2);
for i = 1+half_size:length(data)-half_size
    windowed_data(i-half_size,1) = data(i,1);
    windowed_data(i-half_size,2) = ...
        mean(data(i-half_size:i+half_size,2));
end

clear data1 data2 data3 data4 data5 data

volBeads = 0:0.25:13.5;
volBeads = volBeads';

% NOTE: DIDN'T DO THESE INDICES YET
% mean_per_stage = zeros(length(volBeads),2);
% % minutes
% mean_per_stage(1,:) = [1.4 mean(windowed_data(1:37000,2))];
% mean_per_stage(2,:) = [4.5 mean(windowed_data(44500:82000,2))];
% mean_per_stage(3,:) = [7.9 mean(windowed_data(95485:132445,2))];
% mean_per_stage(4,:) = [11.3 mean(windowed_data(149020:179950,2))];
% mean_per_stage(5,:) = [13.5 mean(windowed_data(186550:223000,2))];
% mean_per_stage(6,:) = [16.3 mean(windowed_data(230500:257500,2))];
% mean_per_stage(7,:) = [18.9 mean(windowed_data(266950:294850,2))];
% mean_per_stage(8,:) = [21.3 mean(windowed_data(302500:330400,2))];
% mean_per_stage(9,:) = [23.7 mean(windowed_data(348250:374875,2))];
% mean_per_stage(10,:) = [27 mean(windowed_data(383800:425950,2))];
% mean_per_stage(11,:) = [30.2 mean(windowed_data(431950:481300,2))];
% mean_per_stage(12,:) = [33.5 mean(windowed_data(488500:518050,2))];
% mean_per_stage(13,:) = [36.4 mean(windowed_data(528250:565900,2))];
% mean_per_stage(14,:) = [39.4 mean(windowed_data(574300:607150,2))];
% mean_per_stage(15,:) = [42.5 mean(windowed_data(620050:652150,2))];
% mean_per_stage(16,:) = [45.5 mean(windowed_data(665200:709900,2))];
% mean_per_stage(17,:) = [49.5 mean(windowed_data(717550:762250,2))];
% mean_per_stage(18,:) = [52.5 mean(windowed_data(768175:801250,2))];
% mean_per_stage(19,:) = [55 mean(windowed_data(809500:842200,2))];
% mean_per_stage(20,:) = [57.5 mean(windowed_data(847750:882550,2))];
% mean_per_stage(21,:) = [60.25 mean(windowed_data(892000:914950,2))];
% mean_per_stage(22,:) = [62.5 mean(windowed_data(925000:953050,2))];
% mean_per_stage(23,:) = [65.25 mean(windowed_data(959800:996850,2))];
% mean_per_stage(24,:) = [68 mean(windowed_data(1004500:1035700,2))];
% mean_per_stage(25,:) = [70.5 mean(windowed_data(1042000:1072000,2))];
% mean_per_stage(26,:) = [72.75 mean(windowed_data(1078300:1113550,2))];
% mean_per_stage(27,:) = [75.75 mean(windowed_data(1123750:1148500,2))];
% mean_per_stage(28,:) = [78.25 mean(windowed_data(1155550:1194100,2))];
% mean_per_stage(29,:) = [81.25 mean(windowed_data(1199500:1239550,2))];
% mean_per_stage(30,:) = [84 mean(windowed_data(1248100:1274050,2))];
% mean_per_stage(31,:) = [87.1 mean(windowed_data(1283500:1329550,2))];
% mean_per_stage(32,:) = [90.6 mean(windowed_data(1336000:1381000,2))];
% mean_per_stage(33,:) = [94.25 mean(windowed_data(1385650:1453450,2))];
% mean_per_stage(34,:) = [98.75 mean(windowed_data(1461550:1499500,2))];
% mean_per_stage(35,:) = [101.5 mean(windowed_data(1505500:1547500,2))];
% mean_per_stage(36,:) = [104.25 mean(windowed_data(1553500:1577500,2))];
% mean_per_stage(37,:) = [107 mean(windowed_data(1585000:1621000,2))];
% mean_per_stage(38,:) = [109.3 mean(windowed_data(1628500:1652500,2))];
% mean_per_stage(39,:) = [111.2 mean(windowed_data(1658500:1676500,2))];
% mean_per_stage(40,:) = [112.7 mean(windowed_data(1682500:1697500,2))];
% mean_per_stage(41,:) = [114 mean(windowed_data(1703500:1715500,2))];
% mean_per_stage(42,:) = [115.5 mean(windowed_data(1721500:1739500,2))];
% mean_per_stage(43,:) = [117 mean(windowed_data(1747000:1759000,2))];
% mean_per_stage(44,:) = [118.3 mean(windowed_data(1765000:1781500,2))];
% mean_per_stage(45,:) = [120.5 mean(windowed_data(1789000:1825000,2))];
% mean_per_stage(46,:) = [123 mean(windowed_data(1834000:1853500,2))];
% mean_per_stage(47,:) = [126 mean(windowed_data(1858000:1916500,2))];
% mean_per_stage(48,:) = [131.5 mean(windowed_data(1925500:2023000,2))];
% mean_per_stage(49,:) = [137.25 mean(windowed_data(2039500:2078500,2))];
% mean_per_stage(50,:) = [140 mean(windowed_data(2086000:2110000,2))];
% mean_per_stage(51,:) = [142.2 mean(windowed_data(2119000:2146000,2))];
% mean_per_stage(52,:) = [144.25 mean(windowed_data(2152000:2174500,2))];
% mean_per_stage(53,:) = [146.25 mean(windowed_data(2183500:2206000,2))];
% mean_per_stage(54,:) = [148 mean(windowed_data(2210500:2228500,2))];
% mean_per_stage(55,:) = [149.5 mean(windowed_data(2234500:2251000,2))];

mean_diff = zeros(length(volBeads)-1,1);
for i = 1:length(mean_diff)
    mean_diff(i,1) = mean_per_stage(i+1,2) - mean_per_stage(i,2);
end

vasculature_flow = [79 77 77.67 77 75 75.67 75 74 73.67 73.33 72 71 ...
    71 69.33 70 68.33 67.67 67.67 68 65.67 65 64 62.33 59.67 58.33 ...
    57.33 55.67 55 53 53.33 52 50.67 49 47 47 45.33 45 44 43 43 42 ...
    41.67 41.67 39.67 37.67 37.67 37 36.33 36.33 35.67 34.67 35.67 ...
    34.67 34.67 34.33];

close all
[ Qpre, p, sm, varcov] = fit_logistic(mean_per_stage(:,1), ...
    mean_per_stage(:,2)-mean_per_stage(1,2));
figure;
subplot(3,1,1)
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
plot(mean_per_stage(:,1), mean_per_stage(:,2), 'rx');
subplot(3,1,2)
plot(volBeads, mean_per_stage(:,2),'g*')
hold on
plot(volBeads, Qpre+mean_per_stage(1,2))
ax = gca;
ax.XTick = 0:14;
ax.YTick = 820:10:860;
xlim([0 14])
ylim([820 860])
title('Average Pressure per Embolization Stage')
xlabel('Amount of Beads (mL)')
ylabel('Pressure (mmHg)')
SS_reg = sum((Qpre - mean_per_stage(:,2) + mean_per_stage(1,2)).^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(13, 830, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'right');
text(13, 834, ['Plateau Value: ' num2str(p(2)+mean_per_stage(1,2))], ...
    'HorizontalAlignment', 'right');
subplot(3,1,3)
Fit = polyfit(vasculature_flow',mean_per_stage(:,2),1);
plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
hold on
text(77.5, 850, sprintf('y = %.2fx + %.2f', Fit), ...
    'HorizontalAlignment', 'right');
plot(vasculature_flow, mean_per_stage(:,2), 'ro');
title('Pressure vs Flow')
xlabel('Vasculature Flow (mL/5 seconds)')
ylabel('Pressure (mmHg)')
SS_reg = sum((polyval(Fit,vasculature_flow) - mean_per_stage(:,2)').^2);
SS_tot = sum((mean_per_stage(:,2) - mean(mean_per_stage(:,2))).^2);
rsquared = 1 - SS_reg/SS_tot;
text(77.5, 846.5, ['R^{2} = '  num2str(rsquared)], ...
    'HorizontalAlignment', 'right');
