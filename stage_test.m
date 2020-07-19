% clear;
% constant
N = 100000;
T = 1:300;

% param
k1 = 0.02; k2 = 7;
beta1 = 0.03;
% beta2 = 0.05;
% r = 18; rd = 4;
r = 8.4842; rd = 2.5135;

gamma = 1/14;
lambda = 5;
theta1 = 0.5;  % rate of i to id
theta2 = 0.1;  % rate of e to ed

% initial
E = zeros(length(T), 1);
I = zeros(length(T), 1); I(1)=10;
S =  zeros(length(T), 1); S(1)=N - I(1);
R = zeros(length(T), 1);
Ed = zeros(length(T), 1); Id = zeros(length(T), 1);
close;
incub_list = random('Poisson',lambda, N, 1);
beta2_list = zeros(N,1);
mask = zeros(N,1);mask(1)=1;
% beta2d_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;

% stage 
t1 = 15; t2 = 120;
scl = 3;
% scl2 = 0.95;

for i=1:length(T)-1
    if i < t1
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    elseif i>t1 && i<t2
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r/scl, rd/scl, gamma, k1, k2, theta1, theta2,N,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    else
%         r = r + 0.1;
%         theta1_3 = 1.0;
%         theta1_3 = 0.9;
        theta1_3 = 0.8;

        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd/scl, gamma, k1, k2, theta1_3, theta2, N ,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    end
end


figure(1);
plot(T,S,T,E,T,I,T,R,T,Ed,T,Id);  hold on;
plot([t1,t1],[0,N], 'red:'); hold on;
plot([t2,t2], [0,N], 'red:'); hold on;
plot([length(T)/2,length(T)/2], [0,N], 'red:'); 
grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者', '观测潜伏者', '观测传染者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda), ', beta1 = ', num2str(beta1), ', r = ', num2str(r), ', rd = ', num2str(rd)]);









