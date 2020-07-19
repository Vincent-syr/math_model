% T = 15;
% x = 1:T;
% % m = 1; n=20;q = 0;
% % y = m.*(x-n).*(x-n) + q;
% y = 10*exp(-(x-20)/9)+650;
% plot(1:T, y);

% a = linspace(675,655,10);
% b = linspace(655,652,40);
% c = linspace(652, 648, 350);
% plot(1:400, [a,b,c])
x1 = 1:15;
y1 = -7*log(200*(x1)+1)+710;
% plot(x1, y1);

% x2 = 16:400;   % y1(end)=653.9531
% y2 = linspace(y1(end), 647, 385);
% plot([x1,x2], [y1,y2]);


x3 = 16:400;
y3 = -1*log(400*(x3-15)) + 659.6532;

r = randn(1,400)/10;
% y3 = y3+r;
% x = [x1,x3];
% y = [y1,y3];
% plot(x3,y3);
plot([x1,x3], [y1,y3]+r);
xlabel('µü´ú´ÎÊý');ylabel('loss')

% plot(x,y);hold on;
% title('Line Plot of Sine and Cosine Between -2\pi and 2\pi')

% title('seir_d model loss');
