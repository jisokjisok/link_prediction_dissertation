function moti_attack_motinumber(G)
II=0;
t=1;
B=ones(2,2);
   O=zeros(1,3);
while sum(B(:,2))~=0
[m,m]=size(G);
GS=triu(G);
[A,B]=find(GS);
M=[A,B];
L=length(G);
LM=length(M);
nk=zeros(1,L);
for p=1:LM
    f1=M(p,1);
    f2=M(p,2);
    for f3=1:L
        if f3>f2
            if G(f1,f2)==1 && G(f1,f3)==1 && G(f2,f3)==1   %�����if�������ε�ģ��
%             if (G(f1,f2)==1 && G(f1,f3)==1 && G(f2,f3)~=1) || ...
%                     (G(f1,f2)==1 && G(f1,f3)~=1 && G(f2,f3)==1) || ...
%                     (G(f1,f2)~=1 && G(f1,f3)==1 && G(f2,f3)==1)   %�����if����������ģ��
              
                        II=II+1;

                O(II,1)=f1;
                O(II,2)=f2;
                O(II,3)=f3;
                nk(1,f1)=nk(1,f1)+1;
                nk(1,f2)=nk(1,f2)+1;
                nk(1,f3)=nk(1,f3)+1;  
                
              
            end
        end
    end
end
nk;
O;
b=1:m;
B=[b;nk];
B=B';
% ���⹥��ģ��ȴ�Ľڵ�
%     [order,lo]=sort(B(:,2),'descend');
%     p=lo(1);
%     B(p,2)=0;
%     [i,j]=find(O==p);
%     t1=O(i,1);
%     t2=O(i,2);
%     t3=O(i,3);
%     O(i,:)=0;
%     li=length(i);
%     for d=1:li
%         G(t1(d),t2(d))=0;
%         G(t2(d),t1(d))=0;
%         G(t1(d),t3(d))=0;
%         G(t3(d),t1(d))=0;
%         G(t2(d),t3(d))=0;
%         G(t3(d),t2(d))=0;
%     end
    %���������⹥��
% ��������������ڵ㣬ģ��ʧЧ
f=find(B(:,2));
lf=length(f);
z=linspace(0,1,lf);
   r1=rand(1);
   for u=1:lf
    if (r1>=z(u) & r1<z(u+1))
        P=f(u);
        B(P,2)=0;
    [I,j]=find(O==P);
    t1=O(I,1);
    t2=O(I,2);
    t3=O(I,3);
    O(I,:)=0;
    li=length(I);
    for d=1:li
        G(t1(d),t2(d))=0;
        G(t2(d),t1(d))=0;
        G(t1(d),t3(d))=0;
        G(t3(d),t1(d))=0;
        G(t2(d),t3(d))=0;
        G(t3(d),t2(d))=0;
    end
    end
   end
   %�������������
num(t)=sum(sum(nk))/3;
S=num

          t=t+1;
end
F=0:t-2
% 
%   plot(F,S,'^-r');     %������
% axis([0 t-2 0 max(num)])
% % 
   plot(F,S,'-*r');     %�����
   axis([0 t-2 0 max(num)])
h=1:t-1;
set(gca,'XTickMode','manual','XTick',h);
xlabel('��������t'),ylabel('ģ�������');
legend('ģ�����⹥���ڵ�','ģ����������ڵ�','��ͳ���⹥��','��ͳ�������')
% itisok
    
    
    