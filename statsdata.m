function [fp,timefp,average,sd] = statsdata(x,time)
%plot(x);
%hold on
%x;
[peaks,loc] = findpeaks(-x(1:200));
if (isempty(peaks)==1)
    fp = NaN;
    timefp = NaN;
    average = NaN;
    sd = NaN;
else


fp = -peaks(1);
timefp = time(loc(1));
average = mean(x(loc(1)*2:end));
sd = var(x(loc(1)*2:end),'omitnan');
end

