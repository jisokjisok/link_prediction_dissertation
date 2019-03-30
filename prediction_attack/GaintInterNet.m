%计算极大子图规模,只有在相依网络的子网络节点一一对应的情况下适用

%输入：A1、A2子网络连接矩阵
%     num_node：子网络节点数
%输出： S1 S2 子网络的极大子图规模
function [G1, G2]= GaintInterNet(NetA,NetB)%G1代表netA极大连通图中的节点集合

% [ci1, sizes1] = components(sparse(NetA));%转换为稀疏矩阵计算子图规模
[ci1, sizes1] = components(sparse(NetA));  %cil表示按顺序的节点属于第几个极大子图 sizes代表每个极大子图的个数
n1 = max(sizes1);          %最大子图的个数
maxcom1 = find(sizes1==n1);     %找出极大子图的是第几个子图
[row1 , col1] =size(maxcom1);    %row1代表几个最大子图  col1代表列数为1


i=randi([1 row1],1,1);
temp1 = find(ci1==maxcom1(i));  %找出属于第i个极大连通子图的节点
% temp1 = find(ci1==maxcom1(1))%找出属于第1个极大连通子图的节点
num_Lcc1 = length(temp1);%第i个极大连通子图的节点个数
result1 = num_Lcc1;%极大连通子图个数
if (result1==col1)  %如果极大连通子图个数为1
    G1 = [];%若每个联通子图的规模仅为1，说明没有极大连通子图存在
else
    G1 = temp1;%若每个联通子图的规模不为1，记下连通子图的节点temp1
end


[ci2, sizes2] = components(sparse(NetB));%转换为稀疏矩阵计算子图规模
n2 = max(sizes2);
maxcom2 = find(sizes2==n2);
[row2 , col2] =size(maxcom2);

j=randi([1 row2],1,1);
temp2 = find(ci2==maxcom2(j));
% temp2 = find(ci2==maxcom2(1));
num_Lcc2 = length(temp2);%一个联通子图的节点个数
result2 = num_Lcc2;
if (result2==col2)
    G2 = [];%若每个联通子图的规模仅为1，说明没有极大连通子图存在
else
    G2 = temp2;
end