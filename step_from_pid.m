function step_from_pid(sys, kp, ki, kd)
    pid = tf([kd kp ki], [1 0]);
    fb = feedback(pid*sys, 1);
    step(fb);
end