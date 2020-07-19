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
mask = zeros(N,1); mask(1)=1;
% beta2d_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;



for i = 1:length(T)-1
    dep_e = prob_int(sum(r * beta2_list(mask==1)) * S(i)/N);
    dep_i = prob_int(r*I(i)*beta1*S(i)/N);
    dep_ed = prob_int(sum(rd * beta2_list(mask==2)) * S(i)/N);
    dep_id = prob_int(rd * Id(i) * beta1 * S(i)/N);
    dep = dep_e + dep_i + dep_ed + dep_id;
    
    den_i = 0;
    dedn = 0;
 
    % update p1 and mask
    p1_t = min(p1 + dep, N);
    mask(p1+1:p1_t) = 1;
%     if(p1_t == p1)
%         mask(p1) = 1;
%     else
%        mask(p1:p1_t) = 1;
%     end
    p1 = p1_t;

    for j = 1:p1
        if E_con(j)==-100   % have transmit to I
            if mask(j)~=0
                disp('mask(j~=0)');
                error('error')
%                 mask(j) = 0;
            end
            continue;
        end
        E_con(j) = E_con(j)+1;  % # incubate day +1
        if E_con(j) >= incub_list(j)  % E transmit to I or Ed to Id
            if mask(j)==1
                den_i = den_i + 1;
            elseif mask(j)==2
                dedn = dedn + 1;
            else 
                disp("error mask(j)")
            end
            mask(j) = 0;
            beta2_list(j) = 0;
            E_con(j) = -100;
        end    
        
        
    end
    
    n_mask = sum(mask > 0);
    n_econ = sum(E_con > 0);
    if n_mask ~= n_econ
        disp('n_mask ~= n_econ');
        error('n_mask ~= n_econ')
    end
    
    beta2_list(mask~=0) = (k1*log(k2*E_con(mask~=0) + 1));
    
    
    
    
    if E(i) > 0
        num = prob_int(E(i) * theta2);
        [idx, temp] = find(mask==1);
        rand_idx = randperm(length(idx));
        idx_cho = idx(rand_idx(1:num));
        
        mask(idx_cho)=2;
    else
        num = 0; 
    end    
    
    % delta summary
    din_id = prob_int(I(i) * theta1);
    din_r = prob_int(gamma * I(i));
    dedp = num; 
    din = din_r + din_id;
    didp = din_id + dedn;
    didn = prob_int(gamma * Id(i));

    ds = -dep;
    de = dep- den_i - dedp;
    di = den_i - din;
    ded = dedp - dedn;
    did = didp - didn;
    dr = didn + din_r;
    
    S(i+1) = S(i) + ds;
    E(i+1) = E(i) + de;
    I(i+1) = I(i) + di;
    Ed(i+1) = Ed(i) + ded;
    Id(i+1) = Id(i) + did;
    R(i+1) = R(i) + dr;

end

plot(T,S,T,E,T,I,T,R,T,Ed,T,Id);grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者', '观测潜伏者', '观测传染者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda)]);
     





