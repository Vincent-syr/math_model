import scipy.integrate as spi
from scipy import stats
import numpy as np
import matplotlib.pyplot as plt
import math





# N为人群总数
N = 10000
# β为传染率系数
beta1 = 0.03
beta2 = 0.05
# 接触强度
r = 20  # 平均每天接触20人每天

# gamma为恢复率系数
gamma = 0.1


# I_0为感染者的初始人数
I_0 = 1
# E_0为潜伏者的初始人数
E_0 = 0
# R_0为治愈者的初始人数
R_0 = 0
# S_0为易感者的初始人数
S_0 = N - I_0 - E_0 - R_0
# T为传播时间
T = 100

# S0, E0, I0, R0 = (N-1, 0, 1, 0)
S_list, E_list, I_list, R_list = [[] for i in range(4)]

S_list.append(S0)
E_list.append(E0)
I_list.append(I0)
R_list.append(R0)

# incub_list = np.random.normal(7, 2, N)
incub_list = np.random.poisson(lam=5, size=N)


E_con = np.zeros(N)  # 进入expose的第几天
p1 = 0  
for i in range(T):
    #  delta e, positive
    dep = math.ceil(r* beta1 * I_list[i] * S_list[i]/N + r * beta2 * E_list[i] * S_list[i] / N)
    den = 0  # delta e negative

    for j in range(0, p1):
        # if np.isclose(E_con[j], -100):
        if E_con[j] == -100:     # 已由E转向I
            # print('equal')
            continue

        E_con[j] += 1  # incubate day +1
        if E_con[j] >= incub_list[j]:
            # print("hanppending")
            E_con[j] = -100
            den += 1
    # update
    # E_con[p1: p1+dep] += 1
    p1 = p1 + dep

    ds = -dep
    de = dep - den
    di = den - gamma*I_list[i]
    dr = gamma*I_list[i]
    # append
    S_list.append(S_list[i] + ds)
    E_list.append(E_list[i] + de)
    I_list.append(I_list[i] + di)
    R_list.append(R_list[i] + dr)

print("p1 = ", p1)
plt.plot(S_list,color = 'darkblue',label = 'Susceptible',marker = '.')
plt.plot(E_list,color = 'orange',label = 'Exposed',marker = '.')
plt.plot(I_list,color = 'red',label = 'Infection',marker = '.')
plt.plot(R_list,color = 'green',label = 'Recovery',marker = '.')

plt.title('SEIR Model')
plt.legend()
plt.xlabel('Day')
plt.ylabel('Number')
plt.show()
