function [ sim ] = LRW( train,test,steps,lambda )
%%����LRWָ�겢����AUCֵ
deg=repmat(sum(train,2),[1,size(train,2)]);
train=train./deg;clear deg;
%��ת�ƾ���
I=sparse(eye(size(train,1)));
%���ɵ�λ����
sim=I;
stepi=0;
while(stepi<steps)
    %������ߵĵ���
    sim=(1-lambda)*I+lambda*train'*sim;
    stepi=stepi+1;
end
sim=sim+sim';
%���ƶȾ���������
train=spones(train);
%���ھӾ���ԭ����Ϊ�޹����㣬���Բ����нڵ�Ķ�Ϊ0
end




