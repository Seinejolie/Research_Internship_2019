function [] = EyeMovements(edf0)

    posX_left = edf0.Samples.posX(:,1);
    posX_right = edf0.Samples.posX(:,2);
    posY_left = edf0.Samples.posY(:,1);
    posY_right = edf0.Samples.posY(:,2);
    %% Smooth the data
    
    posX_left = average_10(posX_left);
    posY_left = average_10(posY_left);
    posX_right = average_10(posX_right);
    posY_right = average_10(posY_right);
    p_length = length(posY_left);
figure(2)
        %% free time view (1) for 15 sec
    subplot(2,1,1)
    plot(posX_left(1:p_length/2), posY_left(1:p_length/2),'o')
    hold on
    plot(posX_right(1:p_length/2), posY_right(1:p_length/2),'o')
    hold on
    xlabel('posX')
    ylabel('posY')
    legend('left eye','right eye')
    title('Both Eye movements during free time')

       %% fixation time view (2) for 15 sec
    subplot(2,1,2)
    plot(posX_left(p_length/2:end), posY_left(p_length/2:end),'o')
    hold on    
    plot(posX_right(p_length/2:end), posY_right(p_length/2:end),'o')
    hold on
    xlabel('posX')
    ylabel('posY')
    legend('left eye','right eye')
    title('Both Eyes movements during fixating time')
    
    suptitle(['Eye Movements Sample:', edf0.matFilename]);
    
    
%         %% whole time    
%     figure('Name','Eye movement during the whole time of observation')
%     plot(posX_left, posY_left,'o')
%     hold on
%     plot(posX_right, posY_right,'o')
%     xlabel('posX')
%     ylabel('posY')
%     title('Both Eyes movements during the whole time')
%     legend('left eye','right eye')
%     
%         %% Heat Map of the eye movement
%     heatmap = edf0.heatmap();
%     plot(edf0)

end

