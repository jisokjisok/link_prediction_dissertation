function SS=sci_attack(G)
[m,m]=size(G);
t=1;
k=sum(G);
[order,lo]=sort(k,'descend');
while sum(sum(G))~=0
    if t>1100
        break
    end
    if mod(t,10)~=0;
        p=lo(t+33);
    else 
        p=lo(m-t);
    end
    G(p,:)=0;
    G(:,p)=0;
    LL=length(G);
    S(1)=1;
    [Acc1,p1] = largest_component(G);
       gg=find(Acc1~=0);
       s=length(gg);
       t=t+1;
       S(t)=s/m;
        [sci1, sizes1] = scomponents(G);
        S(t) = max(sizes1)/LL;
        t;
        G;
        
        
end
select=1:15:801
F=0:(length(select)-1)
% F=F/800
S=S(select)
F=F./100
length(S)
plot(F,S,'k')
SS=S
return