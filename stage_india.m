N = 1324000000;

T = 1:300;

% param
k1 = 0.02; k2 = 6;
beta1 = 0.03;
% beta2 = 0.05;
r =7.4; rd = 3.4;
gamma = 0.04;
lambda = 6;
theta1 = 0.5;  % rate of i to id
theta2 = 0.1;  % rate of e to ed

% initial
E = zeros(length(T), 1);E(i)=10;
I = zeros(length(T), 1); I(1)=2;
S =  zeros(length(T), 1); S(1)=N - I(1);
R = zeros(length(T), 1);
Ed = zeros(length(T), 1); Id = zeros(length(T), 1);
incub_list = random('Poisson',lambda, N, 1);
beta2_list = zeros(N,1);
mask = zeros(N,1);mask(1)=1;
% beta2d_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;


aus_Isum = [1
1
1
2
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
3
5
6
29
30
31
34
43
44
60
73
73
80
102
109
131
120
155
203
287
366
440
487
554
634
641
819
902
1118
1238
1649
1860
2322
2784
3220
3851
4312
4714
5218
6039
6634
7409
8048
9272
10197
10824
11616
12289
13295
14255
15122
15859
16689
17915
18953
20177
21132
22010
22982
23712
25148
26535
28070
29685
31967
33514
35927
37916
39834
41472
44355
46008
47480
49219
51401
53035
53946
56316
58803
61149
63624
66330
69597
73560
77103
80722
83004
86110
89987
86422
89995
93322
97581
101497
106737
110960
115942
120406
124981
129813
133632
137448
141843
145779
149348
153106
153178
155227
160384
163249
168269
169451
174388
178015
183023
186515
189463
197388
203052
210121
215126
220115
226948
];


rt = r/1.5;
for i = 1:length(T)-1
    if i>30&&i<121
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r/1.5, rd/2, gamma, k1, k2, theta1, theta2,N,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    elseif i>121&&i<length(T)
        if rt < r
            rt = rt + 0.2;
        end
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, rt, rd/2, gamma, k1, k2, theta1, theta2,N,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    else
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    end
end

figure(1);
plot(T,S,T,E,T,I,T,R,T,Ed,T,Id, 'linewidth', 1.2);  hold on;
% plot(T, Id+R, 'g--'); hold on;   % Id + R
plot([t1,t1],[0,N], 'red--'); hold on;
plot([t2,t2], [0,N], 'red--'); hold on;
plot([length(T)/2,length(T)/2], [0,N], 'red:'); 
grid on;

xlabel('天');ylabel('人数')

legend('易感者','潜伏者','传染者','康复者', '观测潜伏者', '观测传染者');
title(['k1 = ', num2str(k1), ', k2 = ', num2str(k2), ', \lambda = ', num2str(lambda), ', beta1 = ', num2str(beta1), ', r = ', num2str(r), ', rd = ', num2str(rd)]);