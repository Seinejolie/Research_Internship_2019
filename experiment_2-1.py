

#-----------------------------------------------------------------

from psychopy import visual
from psychopy import core
from psychopy import event

from time import *

#create a window
mywin = visual.Window(monitor="testMonitor", units="deg")
#fullscr=True,

white_background = visual.Rect(
    win = mywin,
    pos = [0,150],
    units = 'pix',
    width = 400,
    height = 400,
    fillColor = [1,1,1])


point = visual.Circle(
     win = mywin,
     pos = [3.945,4.95],
     edges = 320,
     size = 1.65,
     fillColor = [1,0,0],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0)

left_eye = visual.ImageStim(
	win=mywin,
    image = "../Experiment21/eye1.png",
    pos = [-4.12,4.665])
    
right_eye = visual.ImageStim(
	win=mywin,
    image = "../Experiment21/eye1.png",
    pos = [3.945,4.95])
     
current_image = visual.ImageStim(
	win=mywin,
    image = "../Experiment21/face2.png")


import scipy.io as sio
test = sio.loadmat('Psychtoolbox/posX1.mat')
mX1 = test['posX1']
test = sio.loadmat('Psychtoolbox/posY1.mat')
mY1 = test['posY1']
test = sio.loadmat('Psychtoolbox/posX2.mat')
mX2 = test['posX2']
test = sio.loadmat('Psychtoolbox/posY2.mat')
mY2 = test['posY2']

test = sio.loadmat('Psychtoolbox/pright.mat')
pright = test['pright']

test = sio.loadmat('Psychtoolbox/pleft.mat')
pleft = test['pleft']


nb = 1;
#frames = 500;
[a1 , b1] = right_eye.pos
[a2 , b2] = left_eye.pos


while(nb<min(len(mX2), len(mX1), len(mY1), len(mY2))):
    
    # display instructions and wait
    white_background.draw()
    right_eye.draw()
    #left_eye.draw()
    #current_image.draw()

    point.draw()

    mywin.flip()
    
    m = event.Mouse(win = mywin);
    while(event.waitKeys()): print(m.getPos())
    right_eye.pos = pright[nb]
    left_eye.pos = pleft[nb]
    

    nb=nb+1;

    keys = event.getKeys()
    if(len(keys)>0 and keys[0]=="q"):
        break 


#cleanup
mywin.close()
core.quit()

