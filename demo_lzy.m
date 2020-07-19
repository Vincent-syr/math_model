N = 300000;
T = 1:150;

% param
k1 = 0.02; k2 = 6;
beta1 = 0.03;
% beta2 = 0.05;
r = 8.4842; rd = 2.5135;
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
close;
incub_list = random('Poisson',lambda, N, 1);
beta2_list = zeros(N,1);
mask = zeros(N,1);mask(1)=1;
% beta2d_list = zeros(N,1);
E_con = zeros(N,1);
p1 = 1;
aus_Isum = [2
2
2
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
9
76
124
229
322
400
650
888
1128
1689
2036
2502
3089
3858
4636
5883
7375
9172
10149
12462
15113
17660
21157
24747
27980
31506
41035
47021
53578
59138
63927
69176
74386
80539
86498
92472
97689
101739
105792
110574
115716
120281
125016
129317
132547
135893
139422
143626
147577
152271
156363
159516
162488
165155
168941
172434
175925
178972
181228
183957
187327
189973
192994
195351
197675
199414
201505
201505
205463
207428
209328
210717
211938
213013
214457
215858
217185
218268
219070
219814
221216
222104
223096
223885
224760
225435
225886
226699
227364
228006
228658
229327
229858
230158
230555
231139
231732
232248
232664
233019
233197
233515
233836
234013
234531
234801
234998
235278
235561
235763
236142
236305
236651
236989
237290
237500
238728
238159
238011
238275
238499
238720
238833
239410
239706
239961
240136
240310
240436
240578
240760
];
for i = 1:length(T)-1
    if i>30&&i<121
            [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r/1.5, rd/2, gamma, k1, k2, theta1, theta2,N,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    elseif i>121&&i<length(T)
            r = r + 0.2;
            [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r/1.5, rd/2, gamma, k1, k2, theta1, theta2,N,S(i),E(i),I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    else
        [S(i+1), E(i+1), I(i+1), Ed(i+1), Id(i+1), R(i+1), beta2_list, incub_list, E_con, mask, p1] = seir_v_int(beta1, r, rd, gamma, k1, k2, theta1, theta2,  N, S(i), E(i), I(i), Ed(i), Id(i), R(i), beta2_list, incub_list, E_con, mask, p1);
    end
end
figure(2);
plot(T,aus_Isum,T,Id + R);grid on;

xlabel('天');ylabel('累计确诊人数');

legend('实际确诊','预测确诊');
title('意大利');
