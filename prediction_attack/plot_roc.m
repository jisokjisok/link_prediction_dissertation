%predict  -�������Բ��Լ��ķ�����
%ground_truth -���Լ�����ȷ��ǩ
%auc -����ROC���ߵ������µ����
function auc = plot_roc(predict,ground_truth)
%��ʼ��Ϊ��1,1��
%�����ground_truth������������Ŀpos_num�͸������е���Ŀneg_num
pos_number = sum(ground_truth==1);
neg_number = sum(ground_truth==-1);

m=length(ground_truth);
[pre,index]=sort(predict);
ground_truth=ground_truth(index);
x=zeros(m+1,1);
y=zeros(m+1,1);
zuc=0;
x(1)=1; y(1)=1;
auc=0;
for i=2:m
    TP=sum(ground_truth(i:m)==1);
    FP=sum(ground_truth(i:m)==-1);
    x(i)=FP/neg_number;
    y(i)=TP/pos_number;
    auc=auc+(y(i)+y(i-1))*(x(i-1)-x(i))/2;
end
x(m+1)=0;
y(m+1)=0;
auc=auc+y(m)*x(m)/2;
plot(x,y,'m','LineWidth',2);
% hold on
% mm=[0,1];
% nn=[0,1];
% plot(mm,nn,'--')
end
