import scipy.integrate as spi
from scipy import stats
import numpy as np
import matplotlib.pyplot as plt

# ref: https://zhuanlan.zhihu.com/p/104091330




def run_seir():
    # N为人群总数
    # N = 10000
    N = 50
    # β为传染率系数
    beta1 = 0.03
    beta2 = 0.05
    # 接触强度
    r = 20  # 平均每天接触20人每天
    # sigma为疾病潜伏期导数
    sigma = 1.0/7
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
    # T = 150
    T = 10

    # INI为初始状态下的数组
    INI = (S_0, E_0, I_0, R_0)


    def funcSEIR(inivalue,_):
        ds, de, di, dr = np.zeros(4)
        S, E, I, R = inivalue
        # 易感个体变化
        ds = -(beta1 * r * I * S)/N - (beta2 * r * E * S)/N
        # Y[0] = - (beta*r * X[0] * X[2]) / N
        # 潜伏个体变化
        de =  beta1 * r * I * S/N + beta2 * r * E * S/N - sigma * E
        # Y[1] = (beta*r * X[0] * X[2]) / N - X[1] * sigma
        # 感染个体变化
        di = sigma * E + - gamma * I
        # Y[2] = X[1] * sigma - gamma * X[2]
        # 治愈个体变化
        dr = gamma * I
        # Y[3] = gamma * X[2]
        return (ds, de, di, dr)

    T_range = np.arange(0,T + 1)

    RES = spi.odeint(funcSEIR,INI,T_range)

    plt.plot(RES[:,0],color = 'darkblue',label = 'Susceptible',marker = '.')
    plt.plot(RES[:,1],color = 'orange',label = 'Exposed',marker = '.')
    plt.plot(RES[:,2],color = 'red',label = 'Infection',marker = '.')
    plt.plot(RES[:,3],color = 'green',label = 'Recovery',marker = '.')

    plt.title('SEIR Model')
    plt.legend()
    plt.xlabel('Day')
    plt.ylabel('Number')
    plt.show()




def test():
    #1、定义随机变量
    mu=0    #平均值
    sigma=1     #标准差
    X=np.arange(-5,5,0.1)
    #2、求对应分布的概率
    pList=stats.norm.pdf(X,mu,sigma)   #参数含义为：pdf(发生X次事件,均值为mu,方差为sigma)

    #3、绘图
    plt.plot(X,pList, marker='o', linestyle='None')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('$\mu$=%0.1f, $\sigma^2$=%0.1f'%(mu,sigma))
    plt.show()



def test2():
    mu = 2   # 平均值：每天发生2次事故
    k=7 #次数，现在想知道每天发生4次事故的概率
    #包含了发生0次、1次、2次，3次，4次事故
    X = np.arange(0, k+1,1)
    # X
    pList = stats.poisson.pmf(X,mu)
    plt.plot(X, pList, marker='o',linestyle='None')
    plt.title('泊松分布：平均值mu=%i' % mu)
    plt.show()


def add(a, b):
    c = a + b
    return c    


if __name__ == "__main__":
    run_seir()
    # test()
