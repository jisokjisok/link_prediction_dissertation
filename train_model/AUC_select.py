#! -*- coding=utf-8 -*-
import pylab as pl
import PSO_result
from math import log, exp, sqrt

evaluate_result = "you file path"
db = []  # [score,nonclk,clk]
pos, neg = 0, 0
with open(evaluate_result, 'r') as fs:
    for line in fs:
        nonclk, clk, score = line.strip().split('\t')
        nonclk = int(nonclk)
        clk = int(clk)
        score = float(score)
        db.append([score, nonclk, clk])
        pos += clk
        neg += nonclk

db = sorted(db, key=lambda x: x[0], reverse=True)

xy_arr = []
tp, fp = 0., 0.
for i in range(len(db)):
    tp += db[i][2]
    fp += db[i][1]
    xy_arr.append([fp / neg, tp / pos])

auc = 0.
prev_x = 0
for x, y in xy_arr:
    if x != prev_x:
        auc += (x - prev_x) * y
        prev_x = x

print
"the auc is %s." % auc
