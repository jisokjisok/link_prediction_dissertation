function LG=bianliejuzhen(G)
lg=length(G);
for m=1:lg
    for n=1:lg
        LG((m-1)*lg+n)=G(m,n);
    end
end
LG=LG';