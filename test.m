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
