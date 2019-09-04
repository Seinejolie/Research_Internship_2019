function [heatMap,plotRange] = heatdata(posX, posY)

plotRange = [0,0,0,0];

gaussSize = 80;
gaussSigma = 20;


%% generating data for heatmap
gazedata = [posY, posX];
gazedata = gazedata(~isnan(gazedata(:, 1)), :);

% set minimum x and y to zero
for i=1:size(gazedata, 2)
    gazedata(:, i) = gazedata(:, i) - min(gazedata(:, i));
end

gazedata = ceil(gazedata) + 1;
data = accumarray(gazedata, 1);
data = flipud(data);

%% smoothing the Data
gaze = zeros(size(data));
cut = mean(data(:));
data(data > cut) = cut;

kernel = createGauss(gaussSize, gaussSigma);
heatMap = conv2(data, kernel, 'same');

% map with gazepoints on the value of the mean of the heatmap 
gaze(data > 0) = mean(heatMap(:));

% calculated plotrange (min to max on each axes)
plotRange = [min(posX), max(posX), min(posY), max(posY)];
if plotRange(1) < 0
    plotRange(1:2) = [0, max(posX) + abs(plotRange(1))];
end
if plotRange(3) < 0 
    plotRange(3:4) = [0, max(posY) + abs(plotRange(3))];
end
plotRange = floor(plotRange);
end

