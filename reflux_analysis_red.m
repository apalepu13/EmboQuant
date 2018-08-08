load masks.mat
videos = [6519:6533, 6535:6548, 6550, 6568:6575, 6578:6584, 6586:6594, 6596:6616]';
videos(1:15, 2) = 1; videos(16:29, 2) = 2; videos(30, 2) = 3; videos(31:33, 2) = 4;
videos(34:38, 2) = 5; videos(39:45, 2) = 6; videos(46:54, 2) = 7; videos(55:60, 2) = 8;
videos(61:68, 2) = 9; videos(69, 2) = 10; videos(70:75, 2) = 11; 

data = zeros(length(videos), 4);

for i = 1:length(videos)
    frame = [];
    v = VideoReader(strcat('IMG_', num2str(videos(i, 1)), '.mov'));
    masknum = videos(i, 2);

    j = 1;
    flow1 = [];
    flow2 = [];
    while hasFrame(v)
        frame = rgb2hsv(readFrame(v));

        maskapply1 = frame.*masks(:, :, 1, masknum);
        maskapply2 = frame.*masks(:, :, 2, masknum);

        red1 = maskapply1(:, :, 1);
        red1 = find((red1 < 0.05) | (red1 > 0.95));
        red2 = maskapply2(:, :, 1);
        red2 = find((red2 < 0.05) | (red2 > 0.95));

        sat1 = maskapply1(:, :, 2);
        sat2 = maskapply2(:, :, 2);

        flow1(j) = sum(sat1(red1));
        flow2(j) = sum(sat2(red2));
        j = j+1
    end
    data(i, 1) = max(flow1);
    data(i, 2) = trapz(flow1);
    data(i, 3) = max(flow2);
    data(i, 4) = trapz(flow2);
end

%% Plotting
ip = [13.309516 53.23806402 119.785644 212.9522561 332.7379001]
figure, hold on
for i = 1:5
    averages = [];
    for j = 1:5
        averages = [averages mean(data(15*(i-1)+3*(j-1)+1:15*(i-1)+3*(j-1)+3, 2))];
    end
    plot(ip, averages, 'linewidth', 3)
end
set(gca, 'fontsize', 14)
title('Target AUC of Pixel Saturation', 'fontsize', 16), 
xlabel('Injection Rate (mL/min)')
ylabel('Saturation Integrated Over Time')
legend('0mL Beads', '6mL Beads', '7mL Beads', '8mL Beads', '9mL Beads')
