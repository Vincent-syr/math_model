function [ret] = prob_int(m)
    prob = m - fix(m);
    ret = binornd(1, prob) + fix(m);
end
