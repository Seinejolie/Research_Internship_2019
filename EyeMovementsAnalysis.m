close all
%% generate 

%i = 1;
nb = [1,2,3,4,5,6,7];
maxlength = 5000; %14000
%file_name = strcat(name_init,emotion,int2str(i),".mat")
%name = convertStringsToChars(file_name);
close all
emotion = ["relax", "anxious"];

%nb = [1,2,4];
names = ["kanekosensei","rumi"];
figure(1);
%legend('one','two');

for emotion = emotion
for observer_name = names

edf = cell(5,10000);

if(emotion == "relax")
    color = 'b';
else
    color ='r';
end
for i = nb;
    %% get de edf file
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf{i} = Edf2Mat(file_name);
    
    %% The eye movement and heat
      %EyeMovements(edf{i});
    %% Pupil Size
    
    [left1,left2,right1,right2] = PupilSize(edf{i},maxlength);
    time = linspace(1,20*length(left1),length(left1));
    time_2 = linspace(1,20*length(left2),length(left2));

    subplot(2,1,1)
    title('left eye');
    plot(time,left1,color)
    hold on
%     subplot(2,2,2)
%     title('left eye : fixating time');
%     plot(time_2,left2,color)
%     hold on
%     subplot(2,2,3)
%     title('right eye : free time');
%     plot(time,right1,color)
%     hold on
    subplot(2,1,2)
    title('right eye');
    plot(time_2,right2,color)
    hold on
    
    
end
end
end

suptitle(['Comparison between 2 subjects for the:',emotion]);



%% Load one emotion from observer
 %   clear all
  %  load('two/fearandstress.mat')
    

%% PLOTS
%     
%     nb = [1,2,3,4]
%     %subplot(2,1,1)
%     figure()
%     for j=nb
%         plot(list_left_1{j})
%         hold on
%     end
%     xlabel('time (ms)')
%     ylabel('Pupil size (arbitrary units)')
%     title('Free time view')
%     
%     %subplot(2,1,2)
%     figure()
%     for j=nb;
%         plot(list_left_2{j})
%         hold on
%     end
%     xlabel('time (ms)')
%     ylabel('Pupil size (arbitrary units)')
%     title('Fixating time view')
%    % legend('left eye', 'right eye')
% 
%     sgtitle('Eye pupil size')
% 
%     