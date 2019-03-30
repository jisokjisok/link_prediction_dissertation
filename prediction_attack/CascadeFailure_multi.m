function  [NetAnew,NetBnew,GiantA,GiantB,FailureNodesAnew,L] =CascadeFailure_multi(NetA,NetB,InterLink,FailureNodes)
for wusuowei=1:10000
    
    NetA(FailureNodes,:) = 0;%删除子网络A中相应的行列
    NetA(:,FailureNodes) = 0;
    [Acc,p] = largest_component(NetA);
    pp=ones(length(p),1);
    DELp=pp-p;
    fd=find(DELp);
    fd=fd';
    FailureNodes=[FailureNodes fd];
    
    RAIL_rB = 0;
    lenofFNodes = length(FailureNodes);
    if lenofFNodes ~= 0
        iii = 1;
        for ii = 1:lenofFNodes
            indexofIL1 = find(InterLink(:,1)==FailureNodes(ii));
            lenindexofIL1=length(indexofIL1);
            
            if indexofIL1~=0
                for tt=1:lenindexofIL1
                    
                    indexofB=find(InterLink(:,2)==InterLink(indexofIL1(tt),2));
                    if indexofIL1~=0
                        if length(indexofB)==1
                            RAIL_rB(1,iii) = InterLink(indexofIL1(tt),2);
                            InterLink(indexofIL1(tt),:)=0;
                            iii = iii+1;
                        end
                    end
                end
            end
        end
        
        if RAIL_rB~=0
            NetB(RAIL_rB,:) = 0;%删除子网络B中相依失效的节点
            NetB(:,RAIL_rB) = 0;
        end
    end
    
    [GA,p1] = largest_component(NetA);
    kGA=sum(GA);
    [GiantA]=find(kGA);
    ILinkA = intersect(GiantA,InterLink(:,1));
    
    [GB,p1] = largest_component(NetB);
    kGB=sum(GB);
    [GiantB]=find(kGB);
    
    lenofILinkA = length(ILinkA);
    InterLink(:,1);
    ILinkA;
    
    FailureNodesAnew = 0;
    ILG1_B = 0;
    if lenofILinkA ~= 0
        for jj = 1:lenofILinkA
            indexofILinkA = InterLink(:,1)==ILinkA(jj);
            fiLinkA=find(indexofILinkA);
            lenfiLinkA=length(fiLinkA);
            for ti=1:lenfiLinkA
                ILG1_B(jj) = InterLink(fiLinkA(ti),2);
            end
        end
    end
    lenRAIL_rB= length(RAIL_rB);
    if RAIL_rB~=0                  %删除与B相连的连接矩阵
        for NI = 1: lenRAIL_rB
            indexofRAIL = find(InterLink(:,2)==RAIL_rB(NI));
            lenindexofRAIL=length(indexofRAIL);
            if indexofRAIL~=0
                for NII=1:lenindexofRAIL
                    
                    indexofA=find(InterLink(:,1)==InterLink(indexofRAIL(NII),2));
                    
                    if length(indexofA)==1
                        
                        InterLink(indexofRAIL(tt),:)=0;
                    end
                end
            end
        end
    end
        %
        
        
        ILofA_G2= intersect(ILG1_B,GiantB)';
        Flag1 = isequal(sort(ILofA_G2),sort(ILG1_B));
        Flag2 = isempty(ILofA_G2);%判断是否是1*0的空矩阵
        if Flag1~=1 &&Flag2 ==0
            %先计算A中失效节点，重复进行级联失效的过程
            %1、计算ILink中去除Flag的节点：C = setdiff(A, B) 返回在A中有，而B中没有的值，结果向量将以升序排序返回
            C = setdiff(ILG1_B,GiantB); %返回不属于B极大簇的相依节点编号，再找到对应的A中的节点
            
            %2、根据以上节点在InterLink(:,2)中的行数,找到相应的InterLink(:,1)，即下一次迭代中的输入：A中失效节点
            lenofC = length(C);
            for Ci = 1:lenofC
                indexofILinkA = InterLink(:,2)==C(Ci);
                FailureNodesAnew(Ci) = InterLink(indexofILinkA,1);
            end
        end
        NetA;
        NetB;
        
        FailureNodes=FailureNodesAnew;
        if (FailureNodesAnew)==0
            break
        end
    end
    NetAnew = NetA;%删除FailureNodes后，子网络A的邻接矩阵
    NetBnew = NetB;%删除相依失效的节点后，子网络B的邻接矩阵
    GiantA ;%子网络A的极大簇
    GiantB ;%子网络B的极大簇
    L=InterLink;
