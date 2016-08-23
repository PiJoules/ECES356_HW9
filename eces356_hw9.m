clear;
close all;
clc;

figure;

% ZN Continuous method
sys = tf([1], [1 6 11 6 0]);
kp = 6;
ki = 6/pi;
kd = 3*pi/2;
step_from_pid(sys, kp, ki, kd);
hold on;

% ZN Damped Oscillation method
[kp, ki, kd] = damped_oscillation_tuning(sys);
step_from_pid(sys, kp, ki, kd);
hold on;

% ZN Reaction Curve
[N, L, ~]=find_curve(sys, 0.3, 0.7);
delta = 1;
kp = 1.2*delta/N/L;
ti = L/0.5;
td = 0.5*L;
ki = kp/ti;
kd = kp*td;
step_from_pid(sys, kp, ki, kd);
hold on;

% ZN Coon Reaction Curve
[N, L, T]=find_curve(sys, 0.3, 0.7);
delta = 1;
% Slides have K as steady state output value,
% but this website:\
% https://matlabexamples.wordpress.com/2013/08/16/pid-controller-tuning-using-process-reaction-curve-or-cohen-coon-method/
% has K as N*T. I will stick with lecture slide on this one.
K = 1;

kp = T/(K*L)*(1.33+L/(4*T));
ti = L*(32+6*L/T)/(13+8*L/T);
td = L*(4/(11+2*L/T));

ki = kp/ti;
kd = kp*td;
step_from_pid(sys, kp, ki, kd);

legend('Continuous',...
       'Damped Oscillation',...
       'Reaction Curve',...
       'Coon Reaction Curve');
