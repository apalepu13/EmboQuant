% flow 1 - target
% flow 2 - nontarget
clear; close all;
load 6600.mat
plot(flow1, 'r')
hold on
plot(flow2, 'b')
legend('target', 'nontarget')

%%
clc; format long g; format compact; 

% VALUE INPUT SECTION
target_tmin = ; 
target_tmax = ; 
target_zeroadj = ;

nontarget_tmin = ;
nontarget_tmax = ;
nontarget_zeroadj = ;

nontarget_tmin = ;
nontarget_tmax = ;
% Under the hood 
flow1adj = flow1 - target_zeroadj;
flow2adj = flow2 - nontarget_zeroadj;

% Output section
target_zero_adjust = flow1(t_min)
target_max = max(flow1)
target_duration = target_tmax - target_tmin
target_auc = trapz(flow1adj(target_tmin,target_tmax))

nontarget_zero_adjust = flow2(t_min)
nontarget_max = max(flow2)
nontarget_duration = nontarget_tmax - nontarget_tmin
nontarget_auc = trapz(flow2adj(nontarget_tmin, nontarget_tmax))