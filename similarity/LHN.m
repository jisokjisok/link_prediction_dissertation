function [thisauc]=LHN(train,test)
%%计算LHN1指标并返回AUC值
sim=train*train;
%完成分子的计算，分子同共同邻居算法
deg=sum(train,2);
deg=deg*deg';
%完成分母的计算
sim=sim./deg; %计算的最后结果
sim(isnan(sim))=0;sim(isinf(sim))=0;
end