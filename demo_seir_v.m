clear;
% constant
N = 100000;
T = 1:150;

% param
k1 = 0.02; k2 = 7;
beta1 = 0.03;
% beta2 = 0.05;
r = 10; rd = 2;
gamma = 1/13;
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

for i = 1:length(T)-1
%     [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
end

figure(1);
plot(T,S,T,E,T,I,T,R,T,Ed,T,Id);grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者', '观测潜伏者', '观测传染者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda), ', beta1 = ', num2str(beta1), ', r = ', num2str(r), ', rd = ', num2str(rd)]);
