

#-----------------------------------------------------------------

from psychopy import visual
from psychopy import core
from psychopy import event


#create a window
mywin = visual.Window(monitor="testMonitor", units="deg")
#fullscr=True,

white_background = visual.Rect(
    win = mywin,
    pos = [0,150],
    units = 'pix',
    width = 400,
    height = 100,
    fillColor = [1,1,1])


point = visual.Circle(
     win = mywin,
     pos = [-2.44,4.33],
     edges = 320,
     size = 0.1,
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
    image = "../Experiment21/face1.png")




nb = 1;
frames = 500;

while(True and nb<frames):
    
    # display instructions and wait
    white_background.draw()
    left_eye.draw()
    right_eye.draw()
    current_image.draw()
    mywin.flip()
    
    ##m = event.Mouse(win = mywin);
    ##while(event.waitKeys()): print(m.getPos())
    
    [a , b] = right_eye.pos

    right_eye.pos=[a+1.68/frames,b+0.20/frames]
    [a , b] = left_eye.pos

    left_eye.pos=[a+(1.68/frames),b-0.20/frames]
    nb = nb+1;
    keys = event.getKeys()
    if(len(keys)>0 and keys[0]=="q"):
        break 


#cleanup
mywin.close()
core.quit()

