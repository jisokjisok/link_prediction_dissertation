function [ thisauc ] = CN( train,test )
%%����CNָ�겢����AUCֵ
sim=train*train;
%  ���ƶȾ���ļ���
thisauc=CalcAUC(train,test,sim,n);
%���⣬�����ָ���Ӧ��AUC
end


