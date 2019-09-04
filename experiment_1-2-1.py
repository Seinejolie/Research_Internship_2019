#avoid warnings
from psychopy import logging
logging.console.setLevel(logging.CRITICAL)
#-----------------------------------------------------------------

#tuto 1 : Generate a stimuli
# code qui permet d'afficher un point au milieu
from psychopy import visual
from psychopy import core
from psychopy import event
#random library to sort the elements
from random import *
#time to mesure the time between 2 frames
from time import *


import pylink


#-----------------------------------------------------------------
# tuto 2 setup informations from the observer 
# and save the informations in a file

def sort_emotions_and_video_number():
    #the number of picture for one emotion
    emotions = ['anxious', 'relax']
    id_emotion = []    
    list_names = []
    for i in range(len(emotions)):
        for j in range (7):
            list_names.append(emotions[i]+str(j+1))
    shuffle(list_names)
    return list_names


def change_current_video(current_video, id_video, list_video):
    new_id_video = id_video + 1
    current_video= visual.MovieStim3(mywin,"exp-12/"+list_video[new_id_video]+'.mp4',flipVert=False)
    id_video = id_video+1;
    return [current_video]
#-----------------------------------------------------------------



# get the list of sorted images names
list_video = sort_emotions_and_video_number()
for i in list_video:
    print(i)


observer_name = "test"



#create a window
mywin = visual.Window( fullscr=True,pos =[0,0], color=(-1,-1,-1),monitor="testMonitor", units="deg")
#[1300,750]

id_image = 0;
current_video = visual.MovieStim3(mywin,"exp-12/"+list_video[id_image]+'.mp4',flipVert=False)




# display instructions and wait
message1 = visual.TextStim(mywin, pos=[0,+1],height = 0.5, text='Hit a key when you are ready.')
message1.draw()
mywin.flip()
event.waitKeys()


#draw the stimuli and update the window
num_frame = 0
stop = 0
start = 0
end = 0

time_s =10
#12

frame_max = time_s*60


link = pylink.EyeLink()
author =  observer_name

link.openDataFile(list_video[id_image])
link.startRecording(1,1,1,1)
while(True):
    
    if (num_frame > 10*60):
        message_pause = visual.TextStim(mywin, pos = [0,+1], height = 0.5, text = ' ')
        message_pause.draw()
        mywin.flip()
    else:
        current_video.draw()
        mywin.update()
        
    keys = event.getKeys()
    if(len(keys)>0 and keys[0]=="q"):
        link.stopRecording()
        break 

    if (num_frame == frame_max):
        link.stopRecording()
        if(id_image==13):
            message = visual.TextStim(mywin, pos=[0,+3],text='Thank you.')
            message.draw()
            mywin.flip(2)
            core.wait(5)
            #cleanup
            mywin.close()
            core.quit()  
        while(len(keys)==0):
            message_pause = visual.TextStim(mywin, pos = [0,+1], height = 0.5, text = 'Hit a key when ready for the next image')
            message_pause.draw()
            mywin.flip()
            keys = event.getKeys()
        if(id_image<13):
            current_video.pause()
            id_image = id_image +1 ;
            current_video= visual.MovieStim3(mywin,"exp-12/"+list_video[id_image]+'.mp4',flipVert=False)
        #end = time()
        #print (end-start)    
        num_frame=0
        link.openDataFile(list_video[id_image])
        link.startRecording(1,1,1,1)


    num_frame = num_frame + 1

