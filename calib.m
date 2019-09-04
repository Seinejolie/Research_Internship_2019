function [] = calib(observername)
% path to the observer's directory
% num : face number (1-4)
calib = Edf2Mat(convertStringsToChars(strcat(observername,"/calib2.edf")));

edf0 = calib;


posX1 = calib.Samples.posX(:,1);
posY1 = calib.Samples.posY(:,1);

posX1 = fillmissing(posX1, 'linear');
posY1 = fillmissing(posY1, 'linear');


posX2 = edf0.Samples.posX(:,2);
posY2 = edf0.Samples.posY(:,2);

posX2 = fillmissing(posX2, 'linear');
posY2 = fillmissing(posY2, 'linear');




pos1_X = mean(posX1(300:700));
pos2_X = mean(posX1(1100:1500));
pos3_X = mean(posX1(2000:2400));
pos4_X = mean(posX1(3100:3300));
pos5_X = mean(posX1(3700:4100));

pos1_Y = mean(posY1(300:700));
pos2_Y = mean(posY1(1100:1500));
pos3_Y = mean(posY1(2000:2400));
pos4_Y = mean(posY1(3100:3300));
pos5_Y = mean(posY1(3700:4100));

%Pxi = (pos5_X+pos4_X)/2
%Pyi = (pos2_Y+pos3_Y)/2

Pxi = 559;
Pyi = 422;

[pupil_first,pupil2,pupil3,pupil4] = PupilSize(edf0, 5000);
time = edf0.normalizedTimeline(1:2:end);
time1 = time(1:length(5000));

posX2 = fillmissing(posX2,'spline');
posY2 = fillmissing(posY2,'spline');

posX2 = removeBlinkingPos(posX2,time1);
posY2 = removeBlinkingPos(posY2,time1);


posX2 = average_10(posX2);
posY2 = average_10(posY2);
% for numface = [1 2 3 4]
for numface = [1]
if(numface == 1)
    a1 = 3.945;
    a2 = -4.12;
    b1 = 4.95;
    b2 = 4.665;
    qba = 3.36;
    qeg = 1.3;
    p = 1.65;
end

if(numface == 2)
    a1 = 8.5/2;
    a2 = -9.1/2;
    b1 = 9.3/2;
    b2 = 9.3/2;
    qba = 3.1;
    qeg = 1.1;
    p = 1.79;
end


if(numface == 3)
    a1 = 3.6;
    a2 = -3.365;
    b1 = 2.58;
    b2 = 2.61;
    qba = -2.03+4.7;
    qeg = -3.1+3.44;
    p = 1.25;
end

if(numface == 4)
   a1 = 2.2;
   a2 = -3.3;
   b1 = 1.65;
   b2 = 1.5;
   qba = -4.4+2.2;
   qeg = 0.8;
   p = 0.90;
end


pa = 1/6 * p;
pb = 2/3 * p;


pupil1 = pupil_first * ((pb-pa)/max(pupil_first)) + pa;
pupil1 = pupil1';
namepupil = strcat(observername,"/",int2str(numface),"/calib/","pupil.mat")
save(namepupil,'pupil1','-v7')


%% Qx,qy,

qx = (pos3_X - pos2_X)/(qba) * 3;
qy = (pos5_Y - pos4_Y)/(qeg);

%% Calculs
posX2 = smooth(posX2);
posY2 = smooth(posY2);



for i = linspace(1,500,500)
    pleft(i,1) = a1+(posX2(i)-Pxi)/(qx);
    pleft(i,2) = b1+(posY2(i)-Pyi)/(qy);
    pright(i,1) = a2+(posX2(i)-Pxi)/(qx);
    pright(i,2) = b2+(posY2(i)-Pyi)/(qy);
end


posname = strcat(observername,"/",int2str(numface),"/calib/","pos")
save(strcat(posname,"_left.mat"),'pleft','-v7')
save(strcat(posname,"_right.mat"),'pright','-v7')

end








end