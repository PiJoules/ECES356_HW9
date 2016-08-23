% Get the ratio of the second peak to the first peak from the final steady
% state values and the period between these peaks.
function [ratio, period]=peak_ratio(y, t, ss)
    peak1_idx = find_nth_peak(y, 1);
    period = 0;
    ratio = 0;
    if peak1_idx == 0
        return
    end
    peak1 = y(peak1_idx);

    peak2_idx = find_nth_peak(y, 2);
    if peak2_idx == 0
       return; 
    end
    peak2 = y(peak2_idx);

    period = t(peak2_idx) - t(peak1_idx);
    ratio = (peak2-ss)/(peak1-ss);
end