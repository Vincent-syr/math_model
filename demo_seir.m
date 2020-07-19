% demo

% constant
N = 50000000;
% T = 1:100;
T = 1:162;

% param
k1 = 0.02; k2 = 7;
beta1 = 0.02;
% beta2 = 0.05;
r = 6;
gamma = 0.1;
lambda = 5;

% initial
E = zeros(length(T), 1);
I = zeros(length(T), 1); I(1)=10;
S =  zeros(length(T), 1); S(1)=N - I(1);
R = zeros(length(T), 1);
incub_list = random('Poisson',lambda, N, 1);
inten_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;

for i = 1:length(T)-1
%     [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, p1] = seir(beta1, beta2, r, gamma, N, S(i), E(i), I(i), R(i), incub_list, E_con, p1);
%     [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, inten_list, p1] = seir(beta1, r, gamma, k1, k2, N, S(i), E(i), I(i), R(i), incub_list, E_con, inten_list, p1);
    [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, inten_list, p1] = seir_int(beta1, r, gamma, k1, k2, N, S(i), E(i), I(i), R(i), incub_list, E_con, inten_list, p1);

end

% plot(T,S,T,E,T,I,T,R);grid on;
figure(1);
plot(T,I,T,R, T,USA_I, T,USA_R);grid on;

xlabel('天');ylabel('人数')

% legend('易感者','潜伏者','传染者','康复者');
legend('预测感染者', '预测康复者', '真实感染者', '真实康复者')
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda)]);
