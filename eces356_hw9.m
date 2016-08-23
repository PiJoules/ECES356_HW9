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
   
% Prob 2
figure;
sys = tf([1], [1 3 2]);

step_from_pid(sys, 13, 0, 0);
hold on;

step_from_pid(sys, 10, 2, 0);
hold on;

% This is not a realistic controller, but it meets the requirements of <10%
% OS and very fast rise time.
% Values for this were actually Kp=10, Ki=6, and Kd=2 before these.
step_from_pid(sys, 1000000000, 1, 100000);

legend(sprintf('Kp=1000000000'),...
       sprintf('Kp=1000000000, Ki=1'),...
       sprintf('Kp=1000000000, Ki=1, Kd=100000'));

