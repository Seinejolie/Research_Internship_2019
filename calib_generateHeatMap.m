function [] = calib_generateHeatMap(edf0,max)
% 
% if (phase == 1)
%     startIdx = 1;
%     endIdx = 7000;
% elseif (phase == 2)
%     startIdx = 7000;
%     endIdx = 14000;
% else
%     startIdx = 1;
%     endIdx = 14000;
% end

startIdx = 1;
endIdx = max;

range = startIdx:endIdx;
assert(numel(range) > 0, 'Edf2Mat:plot:range', ...
    'Start Index == End Index, nothing do be plotted');



figure();

sub = 1;

   
    for eye = [1,2]
        posX = [];
        posY = [];
        subplot(2,2,sub)
        hold on

            posX = [posX; edf0.Samples.posX(range, eye)];
            posY = [posY; edf0.Samples.posY(range, eye)];
        
        [heatMap,plotRange] = heatdata(posX, posY);
        title_name = strcat("eye:", int2str(eye))
        title(title_name);
        image(heatMap);
        sub = sub+1;
    end
    


suptitle(['Eye movements heat map:',emotion]);



end

