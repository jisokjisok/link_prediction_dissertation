function [ sim ] = RWR( train,test,lambda )
%%����RWRָ�겢����AUCֵ
deg=repmat(sum(train,2),[1,size(train,2)]);
train=train./deg;clear deg;
%��ת�ƾ���
train=full(train);
train(isnan(train))=0;train(isinf(train))=0;
I=sparse(eye(size(train,1)));
%���ɵ�λ����
sim=(1-lambda)*pinv(I-lambda*train')*I;
sim=sim+sim';
%���ƶȾ���������
train=spones(train);
%���ڽӾ���ԭ����Ϊ�޹����㣬���Բ����нڵ�Ķ�Ϊ0
end

