close all
emotion = "sad";
nb = [1,3,4,5,6,7];
observer = ["kanekosensei2","rumi2"];






edf = cell(5,5000);
for observer_name = observer
    color = 'b';
    nb = [1,2,3,4,5,6,7];
    if(emotion == "sad")
        nb = [1,2,4,6,7];
    elseif(emotion == "happy")
        nb = [1,3,4,5,6,7];
    elseif(emotion == "relax")
        nb = [1,2,3,4,5,6,7];
    elseif(emotion == "anxious")
        nb = [1,2,3,4,5,6,7];
    end
    
    
    if (observer_name == "rumi" || observer_name == "rumi2")
        color ='r';
        nb = [1,2,3,4,5,6];
        if(emotion == "sad")
            nb = [3,4,6,7];
        elseif(emotion == "happy")
            nb = [1,3,6];
        elseif(emotion == "relax")
            nb = [1,2,3,4,5,7];
        elseif(emotion == "anxious")
            nb = [1,2,4,5,6,7];
        end    
    end
    
    
for i = nb
    file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
    file_name = convertStringsToChars(file_name);
    edf{i} = Edf2Mat(file_name);
end 


subplot(2,1,1)
for i = nb;
    disp("oim");
    %% The eye movement and heat
     % EyeMovements(edf(i));
    %% Pupil Size
    [left1,left2,right1,right2] = PupilSize(edf{i},4999);
    title('right')
    left1 = baseline(right1);
    time = linspace(1,10000,length(left1));
    hold on
    plot(time,left1,color)
   
end
subplot(2,1,2)
for i = nb;
    disp("oim");
    %% The eye movement and heat
     % EyeMovements(edf(i));
    %% Pupil Size
    [left1,left2,right1,right2] = PupilSize(edf{i},4999);
    title('left')
    left1 = baseline(left1);
    time = linspace(1,10000,length(left1));
    hold on
    plot(time,left1,color)
end
end



