x1 = 1:30;
y1 = -60*log(100*x1+1)+3000;
% plot(x1,y1);

x2 = 31:400;  % y1(end)=2460.8
y2 = -10*log(400*(x2-15)) + 3000;
d = y2(1) - y1(end)+2;
y2 = y2-d;
r = randn(1,400)/1;


% plot(x2,y2);
plot([x1,x2], [y1,y2]+r);
xlabel('µü´ú´ÎÊý');ylabel('loss')
