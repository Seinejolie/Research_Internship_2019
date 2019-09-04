function Exp1_demo
%2019/5/18 
%It presents the luminances valuses in full screen.
%Please press any key to present next valuse.

try
    Screen('Preference','SkipSyncTests',1);
    KbName('UnifyKeyNames');
    
    %Visual parameters===================================
    color = [0,13,26,40,53,67,80,93,107,120,134,147,161,174,187,201,214,228,241,255];
    %Pleaser change the valuse from 0 to 255 in integer value
    
    %Open window=======================================
    windowNumber = max(Screen('Screens'));
    [w, windowRect] = Screen('OpenWindow', windowNumber,[],[0 0 800 600]);
    table = input('Which color would you measure? r, g, b or w :','s');
    
    
    %Set up look-up table==============================
    originalLUT = Screen('ReadNormalizedGammaTable', w); % Read the original look-up talbe(LUT)
    
    mylut(:,1) = linspace(0,1,256)'; % Make a linear LUT
    mylut(:,2) = linspace(0,1,256)';
    mylut(:,3) = linspace(0,1,256)';
    
    Screen('LoadNormalizedGammaTable',w,mylut);% Load the own LUT 
    
    %Presentation=======================================
    for i = 1:length(color)
        switch table
            case 'r'
                Screen('FillRect',w,[color(i) 0 0]);
            case 'g'
                Screen('FillRect',w,[0 color(i) 0]);
            case 'b'
                Screen('FillRect',w,[0 0 color(i)]);
            case 'w'
                Screen('FillRect',w,color(i));
        end
        Screen('Flip',w);
        WaitSecs(0.5);
        KbWait;
    end
    
    Screen('LoadNormalizedGammaTable',w,originalLUT);% Put the original LUT back
    sca; % "S"creen "C"lose "A"ll
catch
    sca;
    Screen('LoadNormalizedGammaTable',w,originalLUT);% Put the original LUT back
end
