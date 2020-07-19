function [S, E, I, R, incub_list, E_con, inten_list, p1] = seir_int(beta1, r, gamma, k1, k2, N, S0, E0, I0, R0, incub_list, E_con, inten_list, p1)
%     param:
%         beta1, r, gamma, k1, k2, 
%     T value
%         SO, EO I0, RO
%     T+1 value
%         S, E, I, R
%     hidden condition value
%         E_con, inten_list, p1



    dep_e = prob_int(sum(r * inten_list) * S0/N);  % dep: E contribution
    dep = prob_int(r*beta1 * I0 * S0/N + dep_e);  % de positive

    den = 0;  % delta e negative
    for j = 1:p1
        try
            if E_con(j)==-100   % have transmit to I
                continue;
            end
        catch 
            disp(j)
        end
        
        E_con(j) = E_con(j)+1;  % # incubate day +1
        if E_con(j) >= incub_list(j)  % transmit to I now
            E_con(j) = -100;
            inten_list(j) = 0;   % 
            den = den +1;
        else 
            inten_list(j) = k1*log(k2*E_con(j) + 1);   % intensity update    
        end
        
    end
%     p1 = p1 + dep;
    p1 = min(p1 + dep, N);  
    ds = -dep;
    de = dep - den;
    dr = prob_int(gamma * I0);
    di = den - dr;
    
    S = S0 + ds;
    E = E0 + de;
    I = I0 + di;
    R = R0 + dr;

end

    