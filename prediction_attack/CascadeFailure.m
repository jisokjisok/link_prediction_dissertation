%����ʧЧ
%���룺NetA,NetB ������������ڽӾ���
%     InterLink �������Ӿ���
%     FailureNodes ������A��ʧЧ�ڵ�
%�����NetAnew,NetBnew �������ڵ㼰�����ڵ�ʧЧ��������ڽӾ���
%     GiantA,GiantB  ������������A��B�ļ����
%     FailureNodesAnew ��һ����������A��ʧЧ�ڵ�
%by WJD��2016-03-14

% NetA=[0,1,1,0,0,0;1,0,1,0,0,0;1,1,0,0,1,0;0,0,0,0,1,0;0,0,1,1,0,1;0,0,0,0,1,0];
% NetB=[0,1,0,0,0,1;1,0,0,0,0,0;0,0,0,1,0,0;0,0,1,0,1,0;0,0,0,1,0,1;1,0,0,0,1,0];
% InterLink=[1:6;1:6]';�����ڵ�λ�ö�������
% FailureNodes=[5];
%%
function [NetAnew,NetBnew,GiantA,GiantB,FailureNodesAnew] = CascadeFailure(NetA,NetB,InterLink,FailureNodes)

NetA(FailureNodes,:) = 0;%ɾ��������A����Ӧ������
NetA(:,FailureNodes) = 0;
%����A�б������Ľڵ��š��������Ӿ���InterLink���ҵ�B����Ϊ�������Ӷ�ʧЧ�Ľڵ�RAIL_rB
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
        NetB(RAIL_rB,:) = 0;%ɾ��������B������ʧЧ�Ľڵ�
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
Flag2 = isempty(ILofA_G2);%�ж��Ƿ���1*0�Ŀվ���
if Flag1~=1 &&Flag2 ==0
    %�ȼ���A��ʧЧ�ڵ㣬�ظ����м���ʧЧ�Ĺ���
    %1������ILink��ȥ��Flag�Ľڵ㣺C = setdiff(A, B) ������A���У���B��û�е�ֵ��������������������򷵻�
    C = setdiff(ILG1_B,GiantB); %���ز�����B����ص������ڵ��ţ����ҵ���Ӧ��A�еĽڵ�
    
    %2���������Ͻڵ���InterLink(:,2)�е�����,�ҵ���Ӧ��InterLink(:,1)������һ�ε����е����룺A��ʧЧ�ڵ�
    lenofC = length(C);
    for Ci = 1:lenofC
        indexofILinkA = InterLink(:,2)==C(Ci);
        FailureNodesAnew(Ci) = InterLink(indexofILinkA,1);
    end  
end

NetAnew = NetA;%ɾ��FailureNodes��������A���ڽӾ���
NetBnew = NetB;%ɾ������ʧЧ�Ľڵ��������B���ڽӾ���
GiantA ;%������A�ļ����
GiantB ;%������B�ļ����
