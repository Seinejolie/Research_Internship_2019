
close all
emotion = "relax";
nb = [1,2,3,4,5,6,7];

%nb = 1;
observer_name = "kanekosensei";
r_fp= [];
r_timefp = [];
r_average = [];
r_sd = [];
first_point = [];

for observer_name = ["kanekosensei","rumi", "vincent","kenya"]
    disp(observer_name);
for i = nb
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf= Edf2Mat(file_name);
    %% Pupil Size
    [left1,left2,right1,right2] = PupilSize(edf,4999);
    %disp('right')
    right1 = baseline(right1);
    time = linspace(1,10000,length(right1));
    [fp,timefp,average,sd]=statsdata(right1,time);
    first_point = [first_point,right1(1)];
    r_fp= [r_fp,fp];
    r_timefp = [r_timefp, timefp];
    r_average = [r_average, average];
    r_sd = [r_sd,sd];
end
% 
% subplot(2,2,1)
% suptitle(strcat("observer:1 emotions:",emotion))
% title("First peak")
% plot(r_fp)
% hold on
% 
% subplot(2,2,2)
% title("Time first peak")
% plot(r_timefp)
% hold on
% 
% subplot(2,2,3)
% title("Average value")
% plot(r_average)
% hold on
% 
% subplot(2,2,4)
% title("Standard deviation")
% plot(r_sd) 
% hold on
first = mean(first_point)
fp = mean(r_fp(~isnan(r_fp)))
timefp = mean(r_timefp(~isnan(r_timefp)))
average = mean(r_average(~isnan(r_average)))
sd = mean(r_sd(~isnan(r_sd)))

end
