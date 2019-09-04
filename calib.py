
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


listpos = [[0,0],[-18.7,0],[18.7,0],[0,-10.5],[0,10.5],[0,0]]
mywin = visual.Window(fullscr=True,monitor="testMonitor", units="deg")
nb_frame = 100;
observer = "Seinejo"

import pylink

###link = pylink.EyeLink()
###link.openDataFile("calib")


start = time()

# display instructions and wait
message1 = visual.TextStim(mywin, pos=[0,+1],height = 0.5, text='Hit a key when you are ready.')
message1.draw()
mywin.flip()
event.waitKeys()
###link.startRecording(1,1,1,1)


for i in range( nb_frame*len(listpos)):
    fixation = visual.GratingStim(
        win=mywin, 
        mask = 'circle',
        size=1, 
        pos=listpos[i//nb_frame],
        sf=0, 
        rgb=(255,255,0),
        opacity = 1 )
    fixation.draw()
    mywin.flip()
    keys = event.getKeys()
    if(keys == 'q'):
        break;

end = time();
###link.stopRecording()


print('one round time = ')
print((end-start))

"""
10 secondes en tout 1s par position
"""