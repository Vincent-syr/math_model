% demo

% constant
N = 10000;
% T = 1:100;
T = 1:1000;

% param
k1 = 0.005; k2 = 7;
beta1 = 0.03;
% beta2 = 0.05;
r = 5;
gamma = 0.1;
lambda = 5;

% initial
E = 0;
I = 1;
S = N - I;
R = 0;
incub_list = random('Poisson',lambda, N, 1);
inten_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;

for i = 1:length(T)-1
%     [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, p1] = seir(beta1, beta2, r, gamma, N, S(i), E(i), I(i), R(i), incub_list, E_con, p1);
%     [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, inten_list, p1] = seir(beta1, r, gamma, k1, k2, N, S(i), E(i), I(i), R(i), incub_list, E_con, inten_list, p1);
    [S(i+1), E(i+1), I(i+1), R(i+1), incub_list, E_con, inten_list, p1] = seir_int(beta1, r, gamma, k1, k2, N, S(i), E(i), I(i), R(i), incub_list, E_con, inten_list, p1);

end

plot(T,S,T,E,T,I,T,R);grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda)]);
