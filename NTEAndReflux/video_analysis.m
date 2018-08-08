% flow 1 - target
% flow 2 - nontarget
clear; close all;
load 6611.mat
plot(flow1, 'r')
hold on
plot(flow2, 'b')
legend('target', 'nontarget')

%%
clc; format long g; format compact; 

% VALUE INPUT SECTION
target_tmin = 80; 
target_tmax = 250;

nontarget_tmin = 84;
nontarget_tmax = 195;

% Output section
target_zero_adjust = flow1(target_tmin)
flow1adj = flow1 - target_zero_adjust;
target_max = max(flow1(target_tmin:target_tmax)) - target_zero_adjust
target_duration = target_tmax - target_tmin
target_auc = trapz(flow1adj(target_tmin:target_tmax))

nontarget_zero_adjust = flow2(nontarget_tmin)
flow2adj = flow2 - nontarget_zero_adjust;
nontarget_max = max(flow2(nontarget_tmin:nontarget_tmax)) - nontarget_zero_adjust
nontarget_duration = nontarget_tmax - nontarget_tmin
nontarget_auc = trapz(flow2adj(nontarget_tmin:nontarget_tmax))