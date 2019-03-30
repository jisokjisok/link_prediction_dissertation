import numpy as np
import random

class PSO_AUC:
    def __init__(self, dim, size, iter_num, x_max, max_vel, best_fitness_value=float('Inf'), C1 = 2, C2 = 2, W = 1):
        self.C1 = C1
        self.C2 = C2
        self.W = W
        self.dim = dim  # 粒子的维度
        self.size = size  # 粒子个数
        self.iter_num = iter_num  # 迭代次数
        self.x_max = x_max
        self.max_vel = max_vel  # 粒子最大速度
        self.best_fitness_value = best_fitness_value
        self.best_position = [0.0 for i in range(dim)]  # 种群最优位置
        self.fitness_val_list = []  # 每次迭代最优适应值


        self.Particle_list = [PSO_AUC(self.x_max, self.max_vel, self.dim) for i in range(self.size)]

    def update_vel(self, part):
        for i in range(self.dim):
            vel_value = self.W * part.get_vel()[i] + self.C1 * random.random() * (part.get_best_pos()[i] - part.get_pos()[i]) \
                        + self.C2 * random.random() * (self.get_bestPosition()[i] - part.get_pos()[i])
            if vel_value > self.max_vel:
                vel_value = self.max_vel
            elif vel_value < -self.max_vel:
                vel_value = -self.max_vel
            part.set_vel(i, vel_value)

    def update_pos(self, part):
        for i in range(self.dim):
            pos_value = part.get_pos()[i] + part.get_vel()[i]
            part.set_pos(i, pos_value)
        value = fit_fun(part.get_pos())
        if value < part.get_fitness_value():
            part.set_fitness_value(value)
            for i in range(self.dim):
                part.set_best_pos(i, part.get_pos()[i])
        if value < self.get_bestFitnessValue():
            self.set_bestFitnessValue(value)
            for i in range(self.dim):
                self.set_bestPosition(i, part.get_pos()[i])

    def update(self):
        for i in range(self.iter_num):
            for part in self.Particle_list:
                self.update_vel(part)  # 更新速度
                self.update_pos(part)  # 更新位置
            self.fitness_val_list.append(self.get_bestFitnessValue())  # 每次迭代完把当前的最优适应度存到列表
        return self.fitness_val_list, self.get_bestPosition()


    def initbirds(self, size, solutionSpace):
        birds = []
        for i in range(size):
            position = random.uniform(solutionSpace[0], solutionSpace[1])
            speed = 0
            fit = self.fitFunc(position)
            birds.append(bird(speed, position, fit, position, fit))
        best = birds[0]
        for bird in birds:
            if bird.fit > best.fit:
                best = bird
        return birds, best


    def updateBirds(self):#根据AUC指标计算筛选特征
        for bird in self.birds:
            bird.speed = self.w * bird.speed + self.c1 * random.random() * (
            bird.lBestPosition - bird.position) + self.c2 * random.random() * (self.best.position - bird.position)
            bird.position = bird.position + bird.speed
            bird.fit = self.fitFunc(bird.position)
            y_true = np.array([0, 0, 1, 1])
            y_scores = np.array([0.1, 0.4, 0.35, 0.8])
            roc_auc_score(y_true, y_scores)
            if bird.fit > bird.lBestFit:
                bird.lBestFit = bird.fit
                bird.lBestPosition = bird.position


    def solve(self, maxIter):
        for i in range(maxIter):
            # 更新粒子
            self.updateBirds()
            for bird in self.birds:
                if bird.fit > self.best.fit:
                    self.best = bird
