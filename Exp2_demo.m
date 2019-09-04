function Exp2_demo
%2019/5/24
%Present the 

try
    Screen('Preference','SkipSyncTests',1);
    KbName('UnifyKeyNames');
    
    %Visual parameters===================================
    color = [0,64,191,255];
    grayvalue = 126;
    
    circle_radius = 200; % the size of circle

    Begining_Nostimulus_duration = 1;
    WithStimulus_duration = 4;
    Ending_Nostimulus_duration = 1;
    
    %Open window=======================================
    windowNumber = max(Screen('Screens'));
    [w, windowRect] = Screen('OpenWindow', windowNumber,[],[0 0 800 600]);
    [centerx, centery] = RectCenter(windowRect);
    
    %Set up look-up table==============================
    originalLUT = Screen('ReadNormalizedGammaTable', w); % Read the original look-up talbe(LUT)
    
    mylut(:,1) = linspace(0,1,256)'; % Make a linear LUT
    mylut(:,2) = linspace(0,1,256)';
    mylut(:,3) = linspace(0,1,256)';
    
    Screen('LoadNormalizedGammaTable',w,mylut);% Load the own LUT 
    
     %Presentation=======================================
    for i = 1:length(color)
        Screen('FillRect',w,grayvalue);
        Screen('Flip', w);
        WaitSecs(Begining_Nostimulus_duration);
        
        Screen('FillRect',w,grayvalue);
        Screen('FillOval', w, color(i),[centerx-circle_radius/2, centery-circle_radius/2, centerx+circle_radius/2, centery+circle_radius/2]);
        Screen('Flip', w);
        WaitSecs(WithStimulus_duration);
        
        Screen('FillRect',w,grayvalue);
        Screen('Flip', w);
        WaitSecs(Ending_Nostimulus_duration);
    end
    
    Screen('LoadNormalizedGammaTable',w,originalLUT);% Put the original LUT back
    sca; % "S"creen "C"lose "A"ll
catch
    sca;
end
