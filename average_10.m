function [y] = average_10(x)
% Average value for 10 data values -> reduce noise and the amount of data
remove = mod(length(x),10);
xx = reshape(x(1:length(x)-remove),10,[]);
y = sum(xx,1)./size(xx,1);
end

