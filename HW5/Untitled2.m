yseq=[13880,23720, 3.2570e+04]
x=[280000,564480,716800]
plot(x,yseq);
hold on;
ypar=[2880,5058, 5.6712e+03]
plot(x,ypar);
ylabel('time in ms') 
xlabel('resolution in pixels')
legend({'y = cpu','y = gpu'})
% yseqsize=[23720,25710,61939.9];
% x=[5.28,211,324]
% yparsize=[5058,5331,12838.1]
% plot(x,yseqsize);
% hold on;
% plot(x,yparsize);
% ylabel('time in ms') 
% xlabel('filesize in mb')
% legend({'y = cpu','y = gpu'})