
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

def sort_emotions_and_image_number(number = 3):
    #the number of picture for one emotion
    emotions = ['fearandstress', 'relax', 'sadness',\
    'happiness']
    id_emotion = []    
    list_names = []
    for i in range(len(emotions)):
        for j in range (5):
            list_names.append(emotions[i]+str(j+1))
    shuffle(list_names)
    f = open('order.svg', 'wb')
    for i in list_names:
        f.write(i.encode())
        f.write('\n'.encode())
    return list_names


def change_current_image(current_image, id_image):
    new_id_image = id_image + 1
    current_image.setImage("images/"+list_images[new_id_image]+'.jpg')
    return new_id_image
#-----------------------------------------------------------------


link = pylink.EyeLink()


# get the list of sorted images names
list_images = sort_emotions_and_image_number()
for i in list_images:
    print(i)

#create a window
mywin = visual.Window(fullscr=True,monitor="testMonitor", units="deg")

observer_name = 'one'

#create some stimuli
fixation = visual.GratingStim(
	win=mywin, 
    mask = 'circle',
	size=1, 
	pos=[0,0],
 	sf=0, 
 	rgb=(255,255,0),
    opacity = 0.8 )

id_image = 0;
current_image = visual.ImageStim(
	win=mywin,
    image = "images/"+list_images[id_image])


    


# display instructions and wait
message1 = visual.TextStim(mywin, pos=[0,+1],height = 0.5, text='Hit a key when you are ready.')
message2 = visual.TextStim(mywin, pos=[0,-1],height = 0.5, text='Please stare at the point when it appears.')
message1.draw()
message2.draw()
fixation.draw()
mywin.flip()
event.waitKeys()


#draw the stimuli and update the window
num_frame = 0
stop = 0
start = 0
end = 0

time_s = 30
frame_max = time_s*60


link = pylink.EyeLink()
author =  observer_name

link.openDataFile(list_images[id_image])
link.startRecording(1,1,1,1)
while(True):
    current_image.draw()
    if(num_frame>frame_max/2):
        fixation.draw()
    mywin.update()
    keys = event.getKeys()
    if(len(keys)>0 and keys[0]=="q"):
        link.stopRecording()
        break 
    if(id_image==19 and num_frame==frame_max):
        # display end message
        link.stopRecording()
        message = visual.TextStim(mywin, pos=[0,+3],text='Thank you.')
        message.draw()
        mywin.flip(2)
        core.wait(2)
        stop=1
    if(stop==1):
        #cleanup
        mywin.close()
        core.quit()
    if (num_frame == frame_max):
        link.stopRecording()
        while(len(keys)==0):
            message_pause = visual.TextStim(mywin, pos = [0,+1], height = 0.5, text = 'Hit a key when ready for the next image')
            message_pause.draw()
            mywin.flip()
            keys = event.getKeys()
        if(id_image<19):
            id_image = change_current_image(current_image, id_image) 
        #end = time()
        #print (end-start)    
        num_frame=0
        link.openDataFile(author+'/'+list_images[id_image])
        link.startRecording(1,1,1,1)
        start = time()
    num_frame = num_frame + 1
