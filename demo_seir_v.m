clear;
% constant
N = 10000;
T = 1:300;

% param
k1 = 0.008; k2 = 7;
beta1 = 0.03;
% beta2 = 0.05;
r = 10; rd = 2;
gamma = 0.1;
lambda = 5;
theta1 = 0.5;  % rate of i to id
theta2 = 0.1;  % rate of e to ed

% initial
E = 0;
I = 1;
S = N - I;
R = 0;
Ed = 0; Id = 0;
incub_list = random('Poisson',lambda, N, 1);
beta2_list = zeros(N,1);
mask = zeros(N,1);
% beta2d_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;

for i = 1:length(T)-1
%     [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);

end

plot(T,S,T,E,T,I,T,R,T,Ed,T,Id);grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者', '观测潜伏者', '观测传染者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda), ', beta1 = ', beta1, ', r = ', num2str(r), ', rd = ', num2str(rd)]);
