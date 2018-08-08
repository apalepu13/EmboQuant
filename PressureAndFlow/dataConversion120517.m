
data7pt2 = table2array(myData7(:, 2));
for i = 1: size(myData7, 1)
    data7(i, 1) = .004 * i;
end
data7 = [data7 data7pt2];
data1 = table2array(myData1);
data2 = table2array(myData2);
data3 = table2array(myData3);
data4 = table2array(myData4);
data5 = table2array(myData5);
data6 = table2array(myData6);

save('data12052017.mat', 'data1', 'data2', 'data3', 'data4', 'data5', 'data6', 'data7');