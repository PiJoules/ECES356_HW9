% Same as peak_ratiom but given initial kp and the system.
function [ratio, period]=peak_ratio_from_kp(kp, sys, ss)
    pid = tf([kp], [1]);
    fb = feedback(pid*sys, 1);
    [y, t] = step(fb);
    [ratio, period] = peak_ratio(y, t, ss);
end