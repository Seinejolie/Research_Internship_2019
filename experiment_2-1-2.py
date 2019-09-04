
from psychopy import visual
from psychopy import core
from psychopy import event
from time import *


#create a window
#
mywin = visual.Window(fullscr = True, monitor="testMonitor", units="deg")
#fullscr=True,

white_background = visual.Rect(
    win = mywin,
    pos = [0,100],
    units = 'pix',
    width = 445,
    height = 195,
    fillColor = [1,1,1])

a1 = 3.6;
a2 = -3.365;
b1 = 2.58;
b2 = 2.61;
pupil_left = visual.Circle(
     win = mywin,
     pos = [a1,b1],
     edges = 320,
     size = 0.8,
     fillColor = [-1,-1,-1],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0)

pupil_right = visual.Circle(
     win = mywin,
     pos = [a2,b2],
     edges = 320,
     size = 0.8,
     fillColor = [-1,-1,-1],
     lineColor = (0.5,0.5,0.5),
     lineWidth = 0)


#-----------------------------------------------------------------
from random import *

num = 0;
observer = ["rumi2", "kanekosensei2"]
#obs = 'kanekosensei'
emotions =  ["happy","sad"]
n = 4;

list1 = [[0,4],[0,5],[0,6],[0,7],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7]]
list2 = [[0,1],[1,6]]
shuffle(list1)
shuffle(list2)


f = open('order2-1-2.txt', 'w')
message1 = visual.TextStim(mywin, pos=[0,+1],height = 0.5, text='Hit a key when you are ready.')
message1.draw()
mywin.flip()
event.waitKeys()
list = list1
#-----------------------------------------------------------------
start = time()
for obs in observer:
    if (obs == "rumi2"):
        list = list2;
    if (obs == "kanekosensei2") :
        list = list1;
    for i in range (0,len(list)): 
        [em_n,n] = list[i];
        em = emotions[em_n]
        if(i==14):
            i=0;
        num = (num)%4 +1
        #num = 1;
        f.write('['+str(obs)+','+str(em)+','+str(n)+', f'+str(num)+']'+'\n')
        
        evaluation = visual.ImageStim(
            win=mywin,
            image = "../Faces/eval2.png",
            pos = [0,-2],
            size = (25,4))

        left_eye = visual.ImageStim(
            win=mywin,
            image = "../Faces/eye"+str(num)+".png",
            pos = [a1,b1])
            
        right_eye = visual.ImageStim(
            win=mywin,
            image = "../Faces/eye"+str(num)+".png",
            pos = [a2,b2])
             
        current_image = visual.ImageStim(
            win=mywin,
            image = "../Faces/face"+str(num)+".png")


        import scipy.io as sio


        folder = 'Psychtoolbox/'+obs+'/'+str(num);
        subfolder = folder + '/'+em+'/'+str(n);
        #subfolder = folder + '/calib';
        print(subfolder)
        test = sio.loadmat(subfolder+'/pos_right.mat')
        pright = test['pright']
        test = sio.loadmat(subfolder+'/pos_left.mat')
        pleft = test['pleft']
        test = sio.loadmat(subfolder+'/pupil.mat')
        psize = test['pupil1']

        nb = 0;
        #frames = 500;
        [a1 , b1] = right_eye.pos
        [a2 , b2] = left_eye.pos

        a = True;

        while(nb<700):
            # display instructions and wait
            white_background.draw()
            right_eye.draw()
            left_eye.draw()
            pupil_right.draw()
            pupil_left.draw()
            current_image.draw()

            mywin.flip()
            indice = int(nb//1.41);
            if(a):
                ##m = event.Mouse(win = mywin);
                ##while(event.waitKeys()): print(m.getPos())
                right_eye.pos = pright[indice]
                pupil_right.pos = pright[indice]
                left_eye.pos = pleft[indice]
                pupil_left.pos = pleft[indice]
                pupil_right.size = psize[indice]
                pupil_left.size = psize[indice]
            a =True
            nb=nb+1;

            keys = event.getKeys()
            if(len(keys)>0 and keys[0]=="q"):
                mywin.close()
                core.quit()
                break 

        while(len(keys)==0):
                    message_pause = visual.TextStim(mywin, pos = [0,+1], height = 0.5, text = 'Hit a key when ready for the next image')
                    message_pause.draw()
                    evaluation.draw()
                    mywin.flip()
                    keys = event.getKeys()
end = time()
print(end-start)

#cleanup
message = visual.TextStim(mywin, pos=[0,+3],text='Thank you.')
message.draw()
mywin.flip(2)
core.wait(5)
#cleanup
mywin.close()
core.quit()  


