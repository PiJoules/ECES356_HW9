function idx=find_nth_peak(y, n)
    idx = 0;
    peak = 0;
    last = y(1);
    for i=2:(length(y)-1)
        next = y(i+1);
        if next < y(i)
            % Decreasing
            if y(i) > last
                % Was increasing
                % Current is peak
                peak = peak + 1;

                if peak >= n
                    % Break if found nth peak
                    idx = i;
                    break; 
                end
            end
        elseif next > y(i)
            % Increasing
        end
        last = y(i);
    end
end