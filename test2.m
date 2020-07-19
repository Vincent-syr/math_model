% k1 = 0.005; k2 = 7;
% x =0:15;
% y = k1 * log(k2*x + 1);
% plot(x,y, '-o');


plot(T(100:end), s080(100:end), T(100:end), s090(100:end), T(100:end), s100(100:end));
xlabel('Ìì');ylabel('ÈËÊı')

legend('s080','s090','s100');