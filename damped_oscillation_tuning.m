function [kp, ki, kd]=damped_oscillation_tuning(sys)
    step_up = 0.3;
    step_down = 0.05;
    kp = 1;
    [ratio, period] = peak_ratio_from_kp(kp, sys, 1);
    while ratio < 0.25
       kp = kp + step_up;
       [ratio, period] = peak_ratio_from_kp(kp, sys, 1); 
    end
    while ratio > 0.25
       kp = kp - step_down;
       [ratio, period] = peak_ratio_from_kp(kp, sys, 1); 
    end
    
    ti = period/1.5;
    td = period/6;
    ki = kp/ti;
    kd = kp*td;
end