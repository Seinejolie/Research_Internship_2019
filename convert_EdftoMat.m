%% Convert every edf file to mat files

%% Change the file name for each observer
    clear all
    list_edf_names = [""];
    nb = [1,2,3,4,5];
    name_init = "two/";
    emotion_list = ["fearandstress","happiness","sadness","relax"]
    %emotion_list = ["sadness"];

    index = 1;
    
    for emotion = emotion_list;
        for i = nb;
            name = strcat(name_init,emotion,int2str(i),".edf");
            edf_char_names = convertStringsToChars(name);
            edf = Edf2Mat(edf_char_names);
            file_name = strcat(name_init,emotion,"/",int2str(i),".mat")
            save(convertStringsToChars(file_name),'edf');
        end
    end
    
