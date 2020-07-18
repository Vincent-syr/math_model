clear;clc;


%GIVEN
N = 10000;
T = 100;

% param
beta1 = 0.03;
beta2 = 0.05;
r = 20;  % 平均每天接触20人每天
gamma = 0.1;  % recovery
lambda = 5;  % k1 is lambda of possion distribution

S_list = [N-1];
E_list = [0];
I_list = [1];
R_list = [0];

incub_list = random('Poisson',lambda, N, 1);
E_con = zeros(N,1);
p1 = 1;


for i = 1:T
    dep = ceil(r* beta1 * I_list(i) * S_list(i)/N + r * beta2 * E_list(i) * S_list(i) / N);
    den = 0;  % delta e negative
    
    for j = 1:p1
        if E_con(j)==-100
            continue;
        end
        
        E_con(j) = E_con(j)+1;  % # incubate day +1
        if E_con(j) >= incub_list(j)
            E_con(j) = -100;
            den = den +1;
        end
    end
    p1 = p1 + dep;
    
    ds = -dep;
    de = dep - den;
    di = den - gamma * I_list(i);
    dr = gamma * I_list(i);
    
    S_list = [S_list, S_list(i)+ds];
    E_list = [E_list, E_list(i)+de];
    I_list = [I_list, I_list(i)+di];
    R_list = [R_list, R_list(i)+dr];
    
end

plot(1:T+1,S_list, 1:T+1,E_list, 1:T+1,I_list, 1:T+1,R_list);grid on;
xlabel('天');ylabel('人数')
legend('易感者','潜伏者','传染者','康复者')




    
    
    
    

