function E0=removeed(G)
al=input('�������ڸǱߵı���:');   %�ڸǱߵı�����0��1֮��
N=length(G);
tg=triu(G);
W=length(find(tg));
[i,j]=find(tg);
E=[i,j];
kk=sum(G);
[order,lo]=sort(kk,'descend')
G(lo(1,1),:)=0;
G(:,lo(1,1))=0;
nr=W*al;                %�ڸǱߵ�����
nr=round(nr);
%����������ڸ�nr����
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

    


