
close all
emotion = "relax";
nb = [1,2,3,4,5,6,7];

r_fp= [];
r_timefp = [];
r_average = [];
r_sd = [];
first_point = [];

emotion_meansum = [];

for observer_name = ["kanekosensei","rumi","vincent","kenya"]
    disp(observer_name);
    meansum = 0;
for i = nb
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf= Edf2Mat(file_name);
    % on prend que l'oeil gauche
    posX = edf.Samples.posX(:,1);
    posY = edf.Samples.posY(:,1);
    sum = 0;
    for j = linspace(1,length(posX),length(posX))
        a = sqrt(posX(j)*posX(j) + posY(j)*posY(j));
        if(isnan(a)==0)
            sum = sum + a;
        end
    end
    sum = sum/length(posX);
    %disp("sum = ")
    %disp(sum)
    meansum = sum + meansum;
        
    %Eye movements    
    
end

meansum = meansum/length(nb);
disp("meansum per observer = ")
disp(meansum)
emotion_meansum = [emotion_meansum,meansum];

end
mean_emotion = mean(emotion_meansum(~isnan(emotion_meansum)));
disp(emotion);
disp(mean_emotion);

% Anxious = 639.2678
%Relax : 640.0609
% Happy = 653.6397
% Sad =   661.3699

%% Que avec rumi et kaneko
% Anxious =   657.3827

% relax =   676.1677
% Happy =    734.2018
%Sad =   721.2236

%test2
%anxious
%  710.2019
%relax
%693.2131
%sad =   730.5996
%happy =   712.2244


% avec tous :
%happy :   662.3723
%sad :   682.9411
%anxious:   686.9694
%relax:  671.2150







