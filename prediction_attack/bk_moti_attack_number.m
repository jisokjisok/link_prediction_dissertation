function bk_moti_attack_number(G)
W=1;
II=0;
t=1;
L=length(G);
while sum(sum(W))~=0
    nk=zeros(1,L);
    O=zeros(1,3);
    GS=triu(G);
    [A,B]=find(GS);
    M=[A,B];
    L=length(G);
    W=zeros(L,L);
    LM=length(M);
    for p=1:LM
        f1=M(p,1);
        f2=M(p,2);
        for f3=1:L
            if f3>f2
                if G(f1,f2)==1 && G(f1,f3)==1 && G(f2,f3)==1   %这里的if是三角形的模体
                    W(f1,f2)=W(f1,f2)+1;
                    W(f1,f3)=W(f1,f3)+1;
                    W(f2,f3)=W(f2,f3)+1;
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
    [V,Z,f]=find(W);
    f;
    lf=length(f);
    %以下是蓄意攻击
%     if lf~=0
%         [order,lo]=sort(f,'descend');
%         I=lo(1);
%         i1=V(I);
%         i2=Z(I);
%         W(i1,i2)=0;
%     end
% 
%               for p=1:L
%           if G(i1,p)==1 && G(i2,p)==1
%               G(i1,i2)=0;G(i2,i1)=0;
%               G(i1,p)=0;G(p,i1)=0;
%               G(i2,p)=0;G(p,i2)=0;
%           end
%       end
%         

%     以上是蓄意攻击

%以下是随机攻击
z=linspace(0,1,lf);
   r1=rand(1);
      for u=1:lf
    if (r1>=z(u) & r1<z(u+1))
                I=u;
      if V~=0
        i1=V(I);
        i2=Z(I);
        W1=W;
        W(i1,i2)=0;
        W2=W1-W;
        w=sum(sum(W2))
      end
    end
      end
      for p=1:L
          if G(i1,p)==1 && G(i2,p)==1
              G(i1,i2)=0;G(i2,i1)=0;
              G(i1,p)=0;G(p,i1)=0;
              G(i2,p)=0;G(p,i2)=0;
          end
      end


% %     以上是随机攻击
        



    num(t)=sum(sum(nk))/3;
    S=num;
    
    t=t+1;
end
F=0:t-2;

% plot(F,S,'-^r');       %点蓄意
% axis([0 t-2 0 max(num+5)])

   plot(F,S,'-*r');     %点随机
   axis([0 t-2 0 max(num+5)])
   
h=1:t-1;
set(gca,'XTickMode','manual','XTick',h);
xlabel('攻击次数t'),ylabel('模体的数量');
legend('模体蓄意攻击边','模体随机攻击边','传统蓄意攻击','传统随机攻击')