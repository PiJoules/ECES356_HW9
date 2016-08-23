clear;
close all;
clc;

% ZN Continuous method
sys = tf([1], [1 6 11 6 0]);
kp = 6;
ki = 6/pi;
kd = 3*pi/2;
pid = tf([kd kp ki], [1 0]);
fb = feedback(pid*sys, 1);
figure;
step(fb);

% ZN Damped Oscillation method
kp = 1;
ki = 0;
kd = 0;
pid = tf([kd kp ki], [1 0]);
fb = feedback(pid*sys, 1);
[y, t] = step(fb);

peak1_idx = find_nth_peak(y, 1);
peak1 = y(peak1_idx);
peak1_time = t(peak1_idx);

peak2_idx = find_nth_peak(y, 2);
peak2 = y(peak2_idx);
peak2_time = t(peak2_idx);

ratio = peak2/peak1;
while ratio > 1/4
    kp = kp + 0.1;
    pid = tf([kd kp ki], [1 0]);
    fb = feedback(pid*sys, 1);
    [y, t] = step(fb);
    
    peak1_idx = find_nth_peak(y, 1);
    peak1 = y(peak1_idx);
    peak1_time = t(peak1_idx);

    peak2_idx = find_nth_peak(y, 2);
    peak2 = y(peak2_idx);
    peak2_time = t(peak2_idx);

    ratio = peak2/peak1;
end