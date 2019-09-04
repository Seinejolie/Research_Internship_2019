close all

emotion = "happiness";
nb = [1];
observer_name = "one";

edf = cell(5,5000);

for i = nb
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf{i} = Edf2Mat(file_name);
end 


for i = nb
    edf0 = edf{i};
    time = edf0.normalizedTimeline(1:2:end);
    pupil_size_left = edf0.Samples.pa(1:5000,1);
    pupil_size_right = edf0.Samples.pa(7501:12500,2);
    time_1 = time(1:1:length(pupil_size_left));
    time_2 = time_1;

    figure('Name', 'First Plot')
    %plot(time_1 , pupil_size_right);



        %% remove blinking
        [r_left_1] = removeBlinking(pupil_size_left,time_1);
        hold on
        plot(time_1, r_left_1)
      
        %% smooth
        s_r_left_1 = smoothdata(r_left_1);
        hold on
        plot(time_1,s_r_left_1)

        %% Plot
        %figure();
        %subplot(3,2,i)
        %hold on
        %plot(time_1, s_r_left_1,'color', 'r')
        %hold on
        %plot (time_1,r_left_1, 'color','g')
        %hold on
        %plot(time_1, s_r_left_1,'color', 'b')
        %hold on
        %legend('raw data', 'without blinking', 'smooth')
    
end   
    
    