function [] = generateHeatMap(emotion, observer, phase, max)
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

   
for observer_name = observer
    for eye = [1,2]
        posX = [];
        posY = [];
        subplot(2,2,sub)
        hold on
        for i= [1,2,3,4,5]
            file_name = strcat(observer_name,"/",emotion,int2str(i),".edf");
            file_name = convertStringsToChars(file_name);
            edf0 = Edf2Mat(file_name);
            posX = [posX; edf0.Samples.posX(range, eye)];
            posY = [posY; edf0.Samples.posY(range, eye)];
        end
        [heatMap,plotRange] = heatdata(posX, posY);
        title_name = strcat("observer:",observer_name, " eye:", int2str(eye))
        title(title_name);
        image(heatMap);
        sub = sub+1;
    end
    
end

suptitle(['Eye movements heat map:',emotion]);



end

