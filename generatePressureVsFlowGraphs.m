f = fit(vasculature_flow,mean_per_stage(:,2),'exp2');
hold on
plot(f,vasculature_flow, mean_per_stage(:,2),'g*')
Fit = polyfit(vasculature_flow,mean_per_stage(:,2),1);
plot(vasculature_flow, polyval(Fit,vasculature_flow), 'b');
legend('data', 'exp', 'linear')
title('Pressure vs Flow');
ylabel('Pressure (mmHg)')
xlabel('Vasculature Flow (mL/5 seconds)')
set(gca,'FontSize',18)