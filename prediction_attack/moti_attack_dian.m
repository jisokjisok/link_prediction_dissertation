function moti_attack_dian(G)
II=0;
t=1;
GG=find(G~=0);
mm=length(GG);
B=ones(2,2);
O=zeros(1,3);
% while sum(sum(G))~=0
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
    nk
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
%     G(p,:)=0;
%     G(:,p)=0;
    %���������⹥��
    
%     ��������������ڵ㣬ģ��ʧЧ
    f=find(B(:,2));
    lf=length(f);
    z=linspace(0,1,lf);
       r1=rand(1);
       for u=1:lf
        if (r1>=z(u) & r1<z(u+1))
            P=f(u);
            B(P,2)=0;
        [I,j]=find(O==P)
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
    t=t+1;
    LL=length(G);
    S(1)=1;
    
    [Acc1,p1] = largest_component(G);
    gg=find(Acc1~=0);
    s=length(gg);
    S(t)=s/mm;
            
    B;
    if S(t)<0.49
break
end
end
    k=sum(G);
 
    %ģ�幥����֮��ԶȽ������⹥��
%     k=k';
%     j=1:m;
%     j=j';
%     C=[j,k];
%     [order,lo]=sort(C(:,2),'descend');
% 
%     p=C(lo(1),1);
%     G(p,:)=0;
%     G(:,p)=0;
%     
% 
%     [Acc1,p1] = largest_component(G);
%        gg=find(Acc1~=0);
%        s=length(gg);
%        
%           t=t+1;
%        S(t)=s/mm;
% end



F=0:5:t-1;
qs=S(1:5:length(S));
% 
% plot(F,qs,'>-b','MarkerSize',5);     %����
 plot(F,qs,'*-b','MarkerSize',5);     %���
axis([0 t 0.5 1])
h=0:10:t;
set(gca,'XTickMode','manual','XTick',h);
xlabel('t'),ylabel('S(e)');
hl=legend({'MIA','MRA','IA','RA'},'best');
set(gcf,'Position',[400 400 250 205]);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 10);
set(hl,'Box','off');
set(hl,'FontName','Times newman','FontSize',10,'FontWeight','normal');
 xlabel('\fontname\fontname{Times New Roman}\itt\rm ','fontsize',10),
 ylabel('\fontname\fontname{Times New Roman}\itS(e)\rm ','fontsize',10);
