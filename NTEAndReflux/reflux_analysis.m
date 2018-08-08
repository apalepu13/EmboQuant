load(['Data\4-7 data\masks.mat'])
videos = [8705:8709, 8711:8755]';
flows = {};

for i = 1:5
    frame = [];
    v = VideoReader(strcat(Data\4-7 data\IMG_', num2str(videos(i, 1)), '.mov'));
    
    j = 1;

    flow1 = [];
    flow2 = [];
    
    tare = im2double(readFrame(v));
    roi1(:,:,1) = tare(:,:,1).*masks(:, :, 1);
    roi1(:,:,2) = tare(:,:,2).*masks(:, :, 1);
    roi1(:,:,3) = tare(:,:,3).*masks(:, :, 1);
    roi2(:,:,1) = tare(:,:,1).*masks(:, :, 2);
    roi2(:,:,2) = tare(:,:,2).*masks(:, :, 2);
    roi2(:,:,3) = tare(:,:,3).*masks(:, :, 2);
    greentare1 = roi1(:, :, 2);
    bluetare1 = roi1(:, :, 3);
    greentare2 = roi2(:, :, 2);
    bluetare2 = roi2(:, :, 3);
    
    while hasFrame(v)
        frame = im2double(readFrame(v));

        maskapply1(:,:,1) = frame(:,:,1).*masks(:, :, 1);
        maskapply1(:,:,2) = frame(:,:,2).*masks(:, :, 1);
        maskapply1(:,:,3) = frame(:,:,3).*masks(:, :, 1);
        maskapply2(:,:,1) = frame(:,:,1).*masks(:, :, 2);
        maskapply2(:,:,2) = frame(:,:,2).*masks(:, :, 2);
        maskapply2(:,:,3) = frame(:,:,3).*masks(:, :, 2);

        green1 = greentare1 - maskapply1(:, :, 2);
        blue1 = bluetare1 - maskapply1(:, :, 3);
        green2 = greentare2 - maskapply2(:, :, 2);
        blue2 = bluetare2 - maskapply2(:, :, 3);

        flow1(j) = sum(sum(green1))+sum(sum(blue1));
        flow2(j) = sum(sum(green2))+sum(sum(blue2));
        j = j + 1
    end
    flows{1, 1, i} = flow1;
    flows{2, 1, i} = flow2;
    data(i, 1) = max(flow1);
    data(i, 2) = trapz(flow1);
    data(i, 3) = max(flow2);
    data(i, 4) = trapz(flow2);
end

%% Plotting
for i = 1:5
    subplot(5, 1, i)
    hold on, plot(flows{1, 1, i}), plot(flows{2, 1, i})
end
