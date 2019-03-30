function [ sim ] = RWR( train,test,lambda )
%%计算RWR指标并返回AUC值
deg=repmat(sum(train,2),[1,size(train,2)]);
train=train./deg;clear deg;
%求转移矩阵
train=full(train);
train(isnan(train))=0;train(isinf(train))=0;
I=sparse(eye(size(train,1)));
%生成单位矩阵
sim=(1-lambda)*pinv(I-lambda*train')*I;
sim=sim+sim';
%相似度矩阵计算完成
train=spones(train);
%将邻接矩阵还原，因为无孤立点，所以不会有节点的度为0
end

