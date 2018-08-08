clearvars;
load('data12052017.mat');
datas = {data1, data2, data3, data4, data5, data6, data7};
sizes = zeros(size(datas));
sizes(1) = size(datas{1}, 1)/250;
for i = 2: size(datas, 2)
    sizes(1, i)= sizes(i - 1) + size(datas{i}, 1)/250;
end
for i = 2: size(datas, 2)
    datas{i}(:, 1) = datas{i}(:, 1) + sizes(i-1);
end
data = [datas{1}; datas{2}; datas{3}; datas{4}; datas{5}; datas{6}; datas{7}];
stepLocations = {[1, 0, 300, 350],[1, .5, 500, 550], [1, 1, 920, 960], ...
[1, 1.5, 1245, 1260], [1, 2, 1650, 1680], [2, 2.5, 160, 200], ...
[2, 3, 400, 450], [2, 3.5, 900, 950], [2, 4, 1200, 1250], [2, 4.5, 1575, 1600], ...
[2, 5, 1920,1990], [3, 5.5, 140, 160], [3, 6, 500, 550], [3, 6.5, 950, 1000], ...
[3, 7, 1352, 1382], [3, 7.5, 1750, 1800], [4, 8, 100, 150], [4, 8.5, 550, 575], ...
[4, 9, 1125, 1150], [4, 9.5, 1500, 1550], [4, 10, 1900, 1950], [5, 10.5, 500, 550], ...
[5, 11, 1360, 1380], [5, 11.5, 1675, 1700], [6, 12, 50, 75], [6, 12.5, 533, 550], ...
[6, 13, 900, 910], [6, 13.5, 1250, 1260], [6, 14, 1590, 1610]};

for i = 1: size(stepLocations, 2) 
    concentrations(i) = stepLocations{i}(1,2);
    if stepLocations{i}(1) ~= 1
        interval{i} = [(stepLocations{i}(1,4) + sizes(stepLocations{i}(1)-1)) * 250, (stepLocations{i}(1,3) + sizes(stepLocations{i}(1)-1)) * 250];
    else
        interval{i} = [(stepLocations{i}(1,4)) * 250, (stepLocations{i}(1,3)) * 250];
    end
end

for i = 1: size(interval, 2)
    AVG(1,i) = mean(data(interval{i}(1,2): interval{i}(1,1), 2));
end

figure(1);
plot(concentrations, AVG, 'ro-');
axis([0 14 790 830])
title('Pressure vs Degree of Embolization')
xlabel('Beads Injected (ml)');
ylabel('Pressure (mmHg)');

figure(2);
plot(data(:, 1), data(:, 2));
hold on;
smoothData = smooth(data(:, 2), 100000);
plot(data(:, 1), 824, 'k- ')
hold on;
axis([0 13000 790 830])
plot(data(:, 1), smoothData(:, 1), 'r-', 'LineWidth', 5);


