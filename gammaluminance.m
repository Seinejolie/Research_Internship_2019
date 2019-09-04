 
 close all 
 color = floor(linspace(1,255,10))
 gamma_red = [0.08, 0.26, 0.71, 1.59, 2.96, 4.79, 7.415, 10.02, 13.7, 17.7]
 gamma_green = [0.07, 0.395, 1.46, 3.435, 6.575, 10.8, 16.5, 23.4, 32, 41.3]
 gamma_blue = [0.065, 0.105, 0.215, 0.41, 0.7, 1.095, 1.615, 2.24, 3.03, 3.81]
 
 figure (1)
 plot(color,gamma_red)
 hold on
 plot(color,gamma_blue)
 hold on
 plot(color,gamma_green)
 hold on
 legend('red','blue','green')


 
 
