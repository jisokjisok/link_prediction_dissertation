function weightrandonattack_bian(G)     %��������ߣ����µĶϱ߷�ʽ�;ɵģ�������Ա���Ϊ��ͨ��
t=1;
f=find(G>0);
L=length(f);
[m,m]=size(G);
while sum(sum(G))~=0                  %Ŀ����Ҫ������ȫ���Ͽ�
[n,n]=size(G);
k=sum(G);
for i=1:n
    for j=1:n
W(i,j)=k(i)*k(j);                   %�����Ȩ
W(i,i)=0;
W=triu(W,0);                        %ȡһ�������Ǿ������ȥ���ظ��ı�
if G(i,j)==0
    W(i,j)=0;
end
    end
end
[i,j]=find(W);
w=W(find(W));
C=[i,j,w];                         %���С��е�λ�ú���ֵ����һ�������б��ڷ���Ѱ��λ��
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
%�����ǻ�����
%             G(p,:)=0;
%             G(:,p)=0;
%             G(q,:)=0;
%             G(:,q)=0;                     
%�����Ǳ����
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
% xlabel('ɾ���ߵı���f'),ylabel('��ͨ�Եı仯s');
% legend('weight(xuyi)','weight(suiji)','betweenness(xuyi)','betweenness(suiji)');
% plot(F,S,'-*b');        %������
plot(F,S,'-*r');      %�����
axis([0 t-1 0 1.1])
h=1:t-1;
set(gca,'XTickMode','manual','XTick',h);
xlabel('��������t'),ylabel('��ͨ�Եı仯S(e)');
legend('������','�����','�������','������','������','�����')
        
            
            
            
