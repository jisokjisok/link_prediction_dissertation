function weightrandonattack_bian(G)     %随机攻击边，有新的断边方式和旧的，输出的以边作为连通性
t=1;
f=find(G>0);
L=length(f);
[m,m]=size(G);
while sum(sum(G))~=0                  %目的是要把网络全部断开
[n,n]=size(G);
k=sum(G);
for i=1:n
    for j=1:n
W(i,j)=k(i)*k(j);                   %定义边权
W(i,i)=0;
W=triu(W,0);                        %取一个上三角矩阵便于去掉重复的边
if G(i,j)==0
    W(i,j)=0;
end
    end
end
[i,j]=find(W);
w=W(find(W));
C=[i,j,w];                         %将行、列的位置和数值放在一个矩阵中便于返回寻找位置
kk=length(w);
l=length(find(w));
z=linspace(0,1,kk);
if l==1
    W=zeros(n);
    G=zeros(n);
    
      t=t+1;
else
    r1=rand(1);
for u=1:kk
    if (r1>=z(u)&r1<z(u+1))
        p=C(u,1);
        q=C(u,2);
%以下是混合随机
%             G(p,:)=0;
%             G(:,p)=0;
%             G(q,:)=0;
%             G(:,q)=0;                     
%以下是边随机
           G(p,q)=0;
           G(q,p)=0;
        
    end
end


        LL=length(G);
S(1)=1;
[Acc1,p1] = largest_component(G);
       gg=find(Acc1~=0);
       s=length(gg);
       S(t)=s/L;
          t=t+1;
end      
end
T=1:t;
[I,J]=find(S>0.5);
 LA=length(J);
T1=T(LA+1)  
S(t)=0;
F=0:t-1;

% plot(F,S,'^-b',F,SG,'s-b',F,R,'^-r',F,ST,'s-r');
% xlabel('删除边的比例f'),ylabel('连通性的变化s');
% legend('weight(xuyi)','weight(suiji)','betweenness(xuyi)','betweenness(suiji)');
% plot(F,S,'-*b');        %混合随机
plot(F,S,'-*r');      %边随机
axis([0 t-1 0 1.1])
h=1:t-1;
set(gca,'XTickMode','manual','XTick',h);
xlabel('攻击次数t'),ylabel('连通性的变化S(e)');
legend('混合随机','边随机','混合蓄意','边蓄意','点蓄意','点随机')
        
            
            
            
