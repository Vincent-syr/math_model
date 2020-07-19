function [S, E, I, Ed, Id, R, beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S0, E0, I0, Ed0, Id0, R0, beta2_list, incub_list, E_con, mask, p1)

% assert sum(mask(==0)) == sum([E_con==0, E_con==-100])


    dep_e = prob_int(sum(r * beta2_list(mask==1)) * S0/N);
    dep_i = prob_int(r*I0*beta1*S0/N);
    dep_ed = prob_int(sum(rd * beta2_list(mask==2)) * S0/N);
    dep_id = prob_int(rd * Id0 * beta1 * S0/N);
    dep = dep_e + dep_i + dep_ed + dep_id;
    
    den_i = 0;
    dedn = 0;
 
    % update p1 and mask
    p1_t = min(p1 + dep, N);
    mask(p1+1:p1_t) = 1;
    p1 = p1_t;

    for j = 1:p1
        if E_con(j)==-100   % have transmit to I
%             if mask(j~=0)
%                 disp(' mask(j~=0)');
%                 error('error')
%             end
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
    end
    
    n_mask = sum(mask > 0);
    n_econ = sum(E_con > 0);
    if n_mask ~= n_econ
        disp('n_mask ~= n_econ');
        error('n_mask ~= n_econ')
    end
    
    beta2_list(mask~=0) = (k1*log(k2*E_con(mask~=0) + 1));
    
    
    
    
    if E0 > 0
        num = prob_int(E0 * theta2);
        [idx, temp] = find(mask==1);
        if isempty(idx)
            num=0;
        else
            rand_idx = randperm(length(idx));
            idx_cho = idx(rand_idx(1:num));
            mask(idx_cho)=2;
        end
    else
        num = 0; 
    end    
    
    % delta summary
    din_id = prob_int(I0 * theta1);
    din_r = prob_int(gamma * I0);
    dedp = num; 
    din = din_r + din_id;
    didp = din_id + dedn;
    didn = prob_int(gamma * Id0);

    ds = -dep;
    de = dep- den_i - dedp;
    di = den_i - din;
    ded = dedp - dedn;
    did = didp - didn;
    dr = didn + din_r;
    
    S = S0 + ds;
    E = E0 + de;
    I = I0 + di;
    Ed = Ed0 + ded;
    Id = Id0 + did;
    R = R0 + dr;
    
end



