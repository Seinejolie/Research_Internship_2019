 

edf0 = Edf2Mat('one/relax2.edf');
blink = edf0.getBlinkTimeline;



[a,b] = edf0.getPupilSize(1,15003);
figure(1)

blink_less = blink(1:2:10000);

res = blink' .* b;
time = floor(linspace(1,30000,length(b)));
plot(a,b);
figure(2)
time = floor(linspace(1,15000,length(blink)));
plot(blink);