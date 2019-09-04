function [left_1,left_2,right_1,right_2] = PupilSize(edf0,max)



%% toutes les 2 milisecondes
time = edf0.normalizedTimeline(1:2:end);

%% phase 1

left1 = edf0.Samples.pa(1:max,1);
right1 = edf0.Samples.pa(1:max,2);

% average value every 10 values
time1 = time(1:length(left1));
r_left1 = removeBlinking(left1,time1);
r_right1 = removeBlinking(right1,time1);

left1 = average_10(r_left1);
right1 = average_10(r_right1);

%left1 = baseline(left1);
%right1 = baseline(right1);

%left1 = left1 - min(left1);
%right1 = right1 - min(right1);

left_1 = smoothdata(left1);
right_1 = smoothdata(right1);

left_2 = left_1;
right_2 = right_1;

%left_1 = left1(1:500);
%right_1 = right1(1:500);

%left_2 = left1(750:1250);
%right_2 = right1(750:1250);

 %% phase 2
%  left2 = edf0.Samples.pa(7501:12500,1);
%  right2 = edf0.Samples.pa(7501:12500,2);
%  time2 = time(1:1:length(right2));
%  
%  r_left2 = removeBlinking(left2,time2);
%  r_right2 = removeBlinking(right2,time2);
%  
%  left2 = average_10(r_left2);
%  right2 = average_10(r_right2);
%  
%  left2= baseline(left2);
%  right2 = baseline(right2);
% 
%  left_2 = smoothdata(r_left2);
%  right_2 = smoothdata(r_right2);

         %% whole result for 30sec
%     figure('Name','Pupil size during the whole time of observation')
%     plot(time, pupil_size_left);
%     hold on
%     xlabel('time (2 ms)')
%     ylabel('Pupil size (arbitrary units)')
%     plot(time, pupil_size_right);
%     hold on
%     xlabel('time (2 ms)')
%     ylabel('Pupil size (arbitrary units)')
%     legend('left eye', 'right eye')
%     title('Pupil size during the whole time of observation')

    % Subtract one pupil size to an other one
    %figure()
    %plot (time, pupil_size_left-pupil_size_right)


end

