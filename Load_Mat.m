    
%% Load all the data just one time
    %change this data
    name_init = "two/";
    index = 1;

    edf = cell(5,5000);
    nb = [1,2,3,4,5];
    emotion_list = ["fearandstress","happiness","sadness","relax"];
    emotion = emotion_list(index)

    for i = nb;
        name = strcat(name_init,emotion,"/",int2str(i),".mat");
        name = convertStringsToChars(name);
        M = load(name);
        edf{i} = M.edf;
    end
    

    
%     
%     plot(list_left_1{1})
%     hold on
%     plot(list_left_1{2})
%     hold on
%     plot(list_left_1{3})
%     hold on 
%     plot(list_left_1{4})
%     hold on
%     plot(list_left_1{5})
