function [y] = baseline(x)
average = mean(x);
y = x - average;
end

