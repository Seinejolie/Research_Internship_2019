

#-----------------------------------------------------------------

from psychopy import visual
from psychopy import core
from psychopy import event


#create a window
mywin = visual.Window([800,800],monitor="testMonitor", units="deg")


right_eye = visual.Circle(
     win = mywin,
     units = 'pix',
     pos = [0,0],
     edges = 320,
     size = 11,
     fillColor = [-1,-1,-1],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0)

left_eye = visual.Circle(
     win = mywin,
     units = 'pix',
     pos = [47,131],
     edges = 320,
     size = 11,
     fillColor = [-1,-1,-1],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0) 
     
     
current_image = visual.ImageStim(
	win=mywin,
    image = "images/"+ "blankface1.jpg")


# display instructions and wait
current_image.draw()
right_eye.draw()
left_eye.draw()
mywin.flip()
event.waitKeys()


#cleanup
mywin.close()
core.quit()

