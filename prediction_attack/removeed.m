function E0=removeed(G)
al=input('请输入掩盖边的比例:');   %掩盖边的比例在0到1之间
N=length(G);
tg=triu(G);
W=length(find(tg));
[i,j]=find(tg);
E=[i,j];
kk=sum(G);
[order,lo]=sort(kk,'descend')
G(lo(1,1),:)=0;
G(:,lo(1,1))=0;
nr=W*al;                %掩盖边的条数
nr=round(nr);
%下面是随机掩盖nr条边
re=randint(nr,1,[1,W]);
lre=length(re);
for T=1:lre
RRE(T,:)=E(re(T),:)
end
[lr,~]=size(RRE);
for tl=1:lr
tg(RRE(tl,1),RRE(tl,2))=0;
G(RRE(tl,1),RRE(tl,2))=0;
G(RRE(tl,2),RRE(tl,1))=0;
end
E0=G;

    


