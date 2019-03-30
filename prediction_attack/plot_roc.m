%predict  -分类器对测试集的分类结果
%ground_truth -测试集的正确标签
%auc -返回ROC曲线的曲线下的面积
function auc = plot_roc(predict,ground_truth)
%初始点为（1,1）
%计算出ground_truth中正样本的数目pos_num和负样本中的数目neg_num
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
