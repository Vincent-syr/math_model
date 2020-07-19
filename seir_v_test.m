clear;
% constant
N = 10000;
T = 1:100;

% param
k1 = 0.02; k2 = 7;
beta1 = 0.03;
% beta2 = 0.05;
r = 20; rd = 5;
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
    dep_e = sum(r * beta2_list(mask==1)) * S(i)/N;
    dep_i = r*I(i)*beta1*S(i)/N;
    dep_ed = sum(rd * beta2_list(mask==2)) * S(i)/N;
    dep_id = rd * Id(i) * beta1 * S(i)/N;
    dep = ceil(dep_e + dep_i + dep_ed + dep_id);
    
    den_i = 0;
    dedn = 0;
 
    p1_t = min(p1 + dep, N);
    mask(p1:p1_t) = 1;
    p1 = p1_t;
   
    for j = 1:p1
        if E_con(j)==-100   % have transmit to I
            mask(j) = 0;
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
                return;
            end
            mask(j) = 0;
            beta2_list(j) = 0;
            E_con(j) = -100;
        end
        
        beta2_list(mask~=0) = (k1*log(k2*E_con(mask~=0) + 1));
    end


    % E to Ed
    if E(i) > 0
        num = fix(E(i) * theta2);
        % num = fix(length(beta2_list(beta2_list>0)) * theta2);
        [idx, temp] = find(mask==1);
        rand_idx = randperm(length(idx));
        idx_cho = idx(rand_idx(1:num));
        
 
        mask(idx_cho)=2;
    else
        num = 0; 
    end
    
    % delta summary
    dedp = num; 
    din = gamma * I(i) + I(i) * theta1;
    didp = I(i) * theta1 + dedn;
    didn = gamma * Id(i);

    ds = -dep;
    de = dep- den_i - dedp;
    di = den_i - din;
    ded = dedp - dedn;
    did = didp - didn;
    dr = gamma * I(i) + gamma * Id(i);
    
    % validation
    val = ds + de + di + ded + did + dr;
    if val > 0.001
        fprintf("val = %f \n", val);
    end
    val2 = S(i) +  E(i) +I(i) +Ed(i) +Id(i) +R(i);
    if val2 - 10000 > 2
        fprintf("val2 = %f \n", val2);
    end
        
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
     





