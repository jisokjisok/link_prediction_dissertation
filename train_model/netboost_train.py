# coding: UTF-8
from __future__ import division
import tensorflow as tf
import numpy as np
import scipy as sp
import base_model
from weakclassify import WEAKC
from dml.tool import sign


class ADABC:
    def __init__(self, X, y, Weaker=WEAKC):
        self.X = np.array(X)
        self.y = np.array(y)
        self.Weaker = Weaker
        self.sums = np.zeros(self.y.shape)
        self.W = np.ones((self.X.shape[1], 1)).flatten(1) / self.X.shape[1]
        tf.reshape(self.W,[len(self.y),0])
        self.Q = 0
        # print self.W
    def sensitive_fun(self,X,y,M):
        self.beta = {}
        self.C=[]
        for i in X:
            c=1/(2*M)
            self.G.setdefault(i)
            self.beta.setdefault(i)
            sensitive_n=0.5*c+0.5
            sensitive_p=-0.5*c+0.5
            c=sensitive_p
            self.C.append(c)
    def network_train(self, M=4):

        self.G = {}
        self.alpha = {}
        for i in range(M):
            self.G.setdefault(i)
            self.alpha.setdefault(i)
        for i in range(M):
            self.G[i] = self.Weaker(self.X, self.y)
            e = self.G[i].train(self.W)
            # print self.G[i].t_val,self.G[i].t_b,e
            self.alpha[i] = 1 / 2 * np.log((1 - e) / e)*self.C[i]
            # print self.alpha[i]
            sg = self.G[i].pred(self.X)
            Z = self.W * np.exp(-self.alpha[i] * self.y * sg.transpose())
            self.W = (Z / Z.sum()).flatten(1)
            self.Q = i
            # print self.finalclassifer(i),'==========='
            if self.finalclassifer(i) == 0:
                break

    def finalclassifer(self, t):

        self.sums = self.sums + self.G[t].pred(self.X).flatten(1) * self.alpha[t]
        # print self.sums
        pre_y = sign(self.sums)
        # sums=np.zeros(self.y.shape)
        # for i in range(t+1):
        #   sums=sums+self.G[i].pred(self.X).flatten(1)*self.alpha[i]
        #   print sums
        # pre_y=sign(sums)
        t = (pre_y != self.y).sum()
        return t

    def pred(self, test_set):
        sums = np.zeros(self.y.shape)
        for i in range(self.Q + 1):
            sums = sums + self.G[i].pred(self.X).flatten(1) * self.alpha[i]
            # print sums
        pre_y = sign(sums)
        return pre_y