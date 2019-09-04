function [res] = removeBlinking(essai,tessai)
%figure('Name','essai first')
%plot(essai)

d_essai = abs(diff(essai));
%figure;
%plot(d_essai)
d_essai_filt = d_essai.*(d_essai>1000);
final_locs = [];
[pks,locs] = findpeaks(d_essai_filt);
% si les pics sont trop proches

if isempty(locs)==1
   res = essai;
   return;
end


% quand on a un entre deux de coupure

% if(locs(2)<100 && locs(1)<100)
%     sprintf('sfdksd');
%     average = mean(essai(2*locs(1)-10)+essai(2*locs(2)+10));
%     essai(1:2*locs(2)+10) = average;
% end 


inverse = zeros(length(essai));
index = 1;
a = locs(index);
i = index+1;
while(i<(length(locs)))
    if((locs(i)-a)>400)
        %fprintf('ecart grand:%d,  a=%d\n ',i,a);
        b = i-1 ;      
        final_locs(index) = (a+locs(b))/2;
        %final_locs(index) = mean(locs(a),locs(b));
        index = index+1;
        a = locs(i);
    else
        i=i+1;
        if(i==length(locs))
            b = length(locs);
            final_locs(index) = (a+locs(b))/2;
        end
    end
end
offset = 70;

i=1;
while(i<=(length(final_locs)))
    %-mod(length(pks),2)
    % pour ne pas prendre les valeurs proches de i
    %fprintf('%d : %d %d\n',i, 2*locs(i), 2*locs(i+1));
    %fprintf('%d %d\n',pks(i), pks(i+1));
    %size = floor(linspace(1,5000,length(essai)));
    %a = rectangularPulse(locs(i)-offset, locs(i+1)+offset,1/2*tessai);
    a = rectangularPulse(final_locs(i)-offset, final_locs(i)+offset,1/2*tessai);
    
    inverse = inverse + a(1:length(essai));
    i = i+1;
end
essai = (~inverse).*essai;
%plot (~inverse)
%figure();
essai(essai==0)=NaN;
reconstruct = fillmissing(essai,'spline');
% mystere de pourquoi il le fait en double
res = reconstruct(:,1);
%figure('Name','Reconstruct');
%plot(tessai, reconstruct)


end

