
close all
emotion = "sad";
nb = [1,2,3,4,5,6,7];

r_fp= [];
r_timefp = [];
r_average = [];
r_sd = [];
first_point = [];

emotion_meansum = [];
varX = [];
varY = [];
len = [];
meanlen = [];
big = [];
for observer_name = ["vincent"]
    disp(observer_name);
    meansum = 0;
for i = [1,2,3,5,6]
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf= Edf2Mat(file_name);
    % on prend que l'oeil gauche
    posX = edf.Samples.posX(1:4999,1);
    posY = edf.Samples.posY(1:4999,1);
    
    
    time = edf.normalizedTimeline(1:2:end);
    time1 = time(1:length(4999));

    posX = fillmissing(posX,'spline');
    posY = fillmissing(posY,'spline');

    posX = removeBlinkingPos(posX,time1);
    posY = removeBlinkingPos(posY,time1);

    posX = average_10(posX);
    posY = average_10(posY);
    
    dposX = diff(posX);
    dposY = diff(posY);
    plot(diff(dposY))
    hold on
    plot(posY)
    len = [len; mean(norm(dposX))];
end
big = [big; mean(len)];
end
disp(big)
res = mean(big)

%meanvarX = mean(varX)
%meanvarY = mean(varY);
%len
