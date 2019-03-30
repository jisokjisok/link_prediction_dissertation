%级联失效
%输入：NetA,NetB 两个子网络的邻接矩阵
%     InterLink 相依连接矩阵
%     FailureNodes 子网络A的失效节点
%输出：NetAnew,NetBnew 被攻击节点及相依节点失效后网络的邻接矩阵
%     GiantA,GiantB  攻击后子网络A、B的极大簇
%     FailureNodesAnew 下一步中子网络A的失效节点
%by WJD，2016-03-14

% NetA=[0,1,1,0,0,0;1,0,1,0,0,0;1,1,0,0,1,0;0,0,0,0,1,0;0,0,1,1,0,1;0,0,0,0,1,0];
% NetB=[0,1,0,0,0,1;1,0,0,0,0,0;0,0,0,1,0,0;0,0,1,0,1,0;0,0,0,1,0,1;1,0,0,0,1,0];
% InterLink=[1:6;1:6]';相依节点位置对照排序
% FailureNodes=[5];
%%
function [NetAnew,NetBnew,GiantA,GiantB,FailureNodesAnew] = CascadeFailure(NetA,NetB,InterLink,FailureNodes)

NetA(FailureNodes,:) = 0;%删除子网络A中相应的行列
NetA(:,FailureNodes) = 0;
%根据A中被攻击的节点编号、相依连接矩阵InterLink，找到B中因为相依连接而失效的节点RAIL_rB
%     RAIL_rA = 0;
RAIL_rB = 0;
lenofFNodes = length(FailureNodes);
if lenofFNodes ~= 0
    iii = 1;
    for ii = 1:lenofFNodes
        indexofIL1 = find(InterLink(:,1)==FailureNodes(ii));
        if indexofIL1~=0
            RAIL_rB(1,iii) = InterLink(indexofIL1,2);
            iii = iii+1;
        end
    end
    if RAIL_rB~=0
        NetB(RAIL_rB,:) = 0;%删除子网络B中相依失效的节点
        NetB(:,RAIL_rB) = 0;
    end
end

[GiantA, GiantB] = GaintInterNet(NetA,NetB);
ILinkA = intersect(GiantA,InterLink(:,1));
lenofILinkA = length(ILinkA);


FailureNodesAnew = 0;
ILG1_B = 0;
if lenofILinkA ~= 0
    for jj = 1:lenofILinkA
        indexofILinkA = InterLink(:,1)==ILinkA(jj);
        ILG1_B(jj) = InterLink(indexofILinkA,2);
        % indexofILinkA = find(InterLink(:,1)==ILinkA(jj));
        % ILinkB(jj) = InterLink(indexofILinkA,2);
    end
end
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

NetAnew = NetA;%删除FailureNodes后，子网络A的邻接矩阵
NetBnew = NetB;%删除相依失效的节点后，子网络B的邻接矩阵
GiantA ;%子网络A的极大簇
GiantB ;%子网络B的极大簇
