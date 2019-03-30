%对应n阶矩阵和2n阶矩阵的相依网络构建

% 正相关相依网络
function linjie=buduichenxiangyi(NetA,NetB)
k1=length(NetA);
k2=length(NetB);
k=k2/k1;   %input('输入不对称的比例k：')
% A=xlsread('C:\Users\wyll\Desktop\新建文件夹\A.xls');
% B=xlsread('C:\Users\wyll\Desktop\新建文件夹\B.xls');
A=NetA;
B=NetB;
 [a1,m1]=sort(sum(A));
 [a2,m2]=sort(sum(B));
 n=size(m1,2);
 B1=zeros(n,k*n);
 d=round((k-1)*rand(1,n));%k=2随机生成0或者1的行向量；round(2*rand(1,10))随机生成0,1,2的行向量
 for i=1:n
    m=m1(i);
    l=m2(k*i-d(i));
    B1(m,l)=1;
 end
M1=[A,B1];
M2=[B1',B];
M=[M1;M2];
linjie=B1;
%负相关相依网络
% A=xlsread('C:\Users\wyll\Desktop\新建文件夹\A.xls');
%  [a1,m1]=sort(sum(A));
%  B=xlsread('C:\Users\wyll\Desktop\新建文件夹\B.xls');
%  [a2,m2]=sort(sum(B));
%  n=size(m1,2);
%  B1=zeros(n,2*n);
%  d=round(1*rand(1,10))%随机生成0或者1的行向量；round(2*rand(1,10))随机生成0,1,2的行向量
%  for i=1:n
%     k=m1(i);
%     l=m2(2*i-d(i));
%     B1(k,l)=1;
%  end
% M1=[A,B1];
% M2=[B1',B];
% M=[M1;M2]

%随机相依网络
% A=xlsread('C:\Users\wyll\Desktop\新建文件夹\A.xls');
%  m1=randperm(length(A));
% B=xlsread('C:\Users\wyll\Desktop\新建文件夹\B.xls');
%  m2=randperm(length(B));
%  n=size(m1,2);
%  B1=zeros(n,2*n);
%  d=round(1*rand(1,10))%随机生成0或者1的行向量；round(2*rand(1,10))随机生成0,1,2的行向量
%  for i=1:n
%     k=m1(i);
%     l=m2(2*i-d(i));
%     B1(k,l)=1;
%  end
% M1=[A,B1];
% M2=[B1',B];
% M=[M1;M2]

% 画图
%%%%画出A网络中的点
% % % % % % % % % % % % for k=1:length(A)
% % % % % % % % % % % %      x0=50*rand(1,1);
% % % % % % % % % % % %      y0=50*rand(1,1);
% % % % % % % % % % % %      x(k)=x0;y(k)=y0;
% % % % % % % % % % % %      plot(x(k),y(k),'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
% % % % % % % % % % % %      hold on
% % % % % % % % % % % % end
% % % % % % % % % % % % % plot(x(k),y(k),'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
% % % % % % % % % % % % 
% % % % % % % % % % % % %%%%画出B网中的点
% % % % % % % % % % % %  hold on
% % % % % % % % % % % % for k=length(A)+1:length(M)
% % % % % % % % % % % %      x0=50*rand(1,1)+100;
% % % % % % % % % % % %      y0=50*rand(1,1);
% % % % % % % % % % % %      x(k)=x0;y(k)=y0;
% % % % % % % % % % % %      plot(x(k),y(k),'ro','MarkerEdgeColor','y','MarkerFaceColor','y','markersize',8);
% % % % % % % % % % % %      hold on
% % % % % % % % % % % % end
% % % % % % % % % % % % % plot(x,y,'ro','MarkerEdgeColor','y','MarkerFaceColor','y','markersize',8);
% % % % % % % % % % % % 
% % % % % % % % % % % % %%%%画出相依网络B1
% % % % % % % % % % % % hold on
% % % % % % % % % % % % for i=1:length(A) 
% % % % % % % % % % % % for j=i+1:length(A)
% % % % % % % % % % % % if M(i,j)~=0
% % % % % % % % % % % %  plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
% % % % % % % % % % % % hold on
% % % % % % % % % % % % end
% % % % % % % % % % % % end
% % % % % % % % % % % % end
% % % % % % % % % % % % lgh=length(M);
% % % % % % % % % % % % for i=length(A)+1:lgh 
% % % % % % % % % % % % for j=i+1:lgh
% % % % % % % % % % % % if M(i,j)~=0
% % % % % % % % % % % %  plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
% % % % % % % % % % % % hold on
% % % % % % % % % % % % end
% % % % % % % % % % % % end
% % % % % % % % % % % % end
% % % % % % % % % % % % hold on
% % % % % % % % % % % % for i=1:length(A)
% % % % % % % % % % % % for j=length(A)+1:lgh
% % % % % % % % % % % % if M(i,j)~=0
% % % % % % % % % % % %  plot([x(i),x(j)],[y(i),y(j)],'linewidth',2.2,'color','r','linestyle',':'); 
% % % % % % % % % % % % hold on
% % % % % % % % % % % % end
% % % % % % % % % % % % end
% % % % % % % % % % % % end
 