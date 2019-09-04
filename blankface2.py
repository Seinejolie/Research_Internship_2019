

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
     pos = [60,275],
     edges = 320,
     size = 22,
     fillColor = [-1,-1,-1],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0) 
     
     
current_image = visual.ImageStim(
	win=mywin,
    image = "images/"+ "blankface3.jpg")

    


#cleanup
mywin.close()
core.quit()

