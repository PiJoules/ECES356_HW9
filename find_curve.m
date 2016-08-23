% p1 and p2 are percentages of the steady state (1 from unit step input)
% N = slope from p1 to where line crosses steady state
% L = Delay until p1
% T = time from p1 to where line crosses steady state
function [N, L, T]=find_curve(sys, p1, p2)
    pid = tf([0 1 0], [1 0]);
    fb = feedback(pid*sys, 1);
    [y, t] = step(fb);
    
    % Find first point
    idx1 = 0;
    for i=1:length(y)
       if y(i) > p1
          idx1 = i;
          break;
       end
    end
    
    % Find second point
    idx2 = 0;
    for i=idx1:length(y)
       if y(i) > p2
          idx2 = i;
          break;
       end
    end
    
    % Slope of line
    N = (y(idx2) - y(idx1))/(t(idx2) - t(idx1));
    
    % Find time when line reaches steady state
    dt = 0.1;
    t2 = 0;  % Time from point idx
    while y(idx2) + t2*N < 1
        t2 = t2 + dt;
    end
    T = t2 + t(idx2) - t(idx1);
    L = t(idx1);
end