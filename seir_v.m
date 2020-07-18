function [S, E, I, Ed, Id, R, beta2_list, incub_list, E_con, mask, p1] = seir_v(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S0, E0, I0, Ed0, Id0, R0, beta2_list, incub_list, E_con, mask, p1)

    dep_e = sum(r * beta2_list(mask==1)) * S0/N;
    dep_i = r*I0*beta1*S0/N;
    dep_ed = sum(rd * beta2_list(mask==2)) * S0/N;
    dep_id = rd * Id0 * beta1 * S0/N;
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
            end
            mask(j) = 0;
            beta2_list(j) = 0;
            E_con(j) = -100;
        end    
        
        beta2_list(mask~=0) = (k1*log(k2*E_con(mask~=0) + 1));
    end
    
    if E0 > 0
        num = fix(E0 * theta2);
        [idx, temp] = find(mask==1);
        rand_idx = randperm(length(idx));
        idx_cho = idx(rand_idx(1:num));
        
        mask(idx_cho)=2;
    else
        num = 0; 
    end    
    
    % delta summary
    dedp = num; 
    din = gamma * I0 + I0 * theta1;
    didp = I0 * theta1 + dedn;
    didn = gamma * Id0;

    ds = -dep;
    de = dep- den_i - dedp;
    di = den_i - din;
    ded = dedp - dedn;
    did = didp - didn;
    dr = gamma * I0 + gamma * Id0;
    
    S = S0 + ds;
    E = E0 + de;
    I = I0 + di;
    Ed = Ed0 + ded;
    Id = Id0 + did;
    R = R0 + dr;
    
end



