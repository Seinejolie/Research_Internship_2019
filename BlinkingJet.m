        %% delete the blinking values
close all
edf0=Edf2Mat('one/happiness1.edf');

essai = edf0.Samples.pa(1:3000,1);
tessai = edf0.normalizedTimeline(1:2:6000);

d_essai = abs(diff(essai));
d_essai = d_essai.*(d_essai>1900);
[pks,locs] = findpeaks(d_essai)

inverse = zeros(length(essai));
a = ones(length(essai));
offset = 20

for i = 1:2:length(pks)
    a = rectangularPulse(locs(i)-offset, locs(i+1)+offset,0.5*tessai);
    inverse = inverse + a;
end

figure()
plot(tessai,essai)
essai = (~inverse).*essai;
essai(essai==0)=NaN;
reconstruct = fillmissing(essai,'spline');
hold on
plot(tessai, reconstruct)







%% 
first_flag = true;
for i = floor(linspace(1,length(essai),length(essai)))
   if (essai(i)>=0 && essai(i)<=2000 && first_flag)
       first_zero = i;
       first_val = essai(i-1);
       first_flag = false;
   end
   if (first_flag==false)
      if (essai(i)>3000)
          last_zero = i+1;
          last_val = essai(i+1);
          average = (first_val+last_val)/2;
          no_blinking_essai(first_zero:last_zero) = average ; 
          first_flag = true;
      end
   end
end
figure()
corrige = no_blinking_essai+essai;
plot(tessai, corrige )


%%
close all
edf0=Edf2Mat('one/happiness1.edf')
essai = edf0.Samples.pa(1:7502,1);
tessai = edf0.normalizedTimeline(1:2:15004);

figure()
plot(tessai, essai)
% supprime les points à 0-3000
essai(essai<=3000) = NaN;
no_blinking_essai = interp1(tessai,essai,tessai,'linear');

% supprimer les lignes verticales
figure()
plot(tessai, no_blinking_essai)
for i = floor(linspace(1,length(essai)-1,length(essai)-1))

    if((essai(i+1)-essai(i))/2<(-50) ||(essai(i+2)-essai(i))/2>30  )
        essai(i)=NaN
    end
end

figure()
plot(tessai, no_blinking_essai)


%% FIIIN SUPPRESSIION BLINKING