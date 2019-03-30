# -*- coding:utf-8 -*-
import system
def extract(tar_path, target_path):
    try:
        tar = tarfile.open(tar_path, "r:gz")
        file_names = tar.getnames()
        for file_name in file_names:
            tar.extract(file_name, target_path)
        tar.close()
    except Exception, e:
        raise Exception, e
def transform_adjacent(A):
    for i in len(A):
        for j in len(B):
            A[i,j]=1
    if A[:]!=A[:]:
        return A
f='./save/jcf_data/kjg.csv'
f=open(f,'w')
f.write(str(i for i in A))