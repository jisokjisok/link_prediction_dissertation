function [sim]=LocalPath(train,test,lambda)
%%����LPָ�겢����aucֵ
sim=train*train;
%����·��
sim=sim+lambda*(train*train*train);
%����·��+����*����·��
%thisauc=CalcAUC(train,test,sim);
%�����������ָ���Ӧ��AUC
end