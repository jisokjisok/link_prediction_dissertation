%���㼫����ͼ��ģ,ֻ�������������������ڵ�һһ��Ӧ�����������

%���룺A1��A2���������Ӿ���
%     num_node��������ڵ���
%����� S1 S2 ������ļ�����ͼ��ģ
function [G1, G2]= GaintInterNet(NetA,NetB)%G1����netA������ͨͼ�еĽڵ㼯��

% [ci1, sizes1] = components(sparse(NetA));%ת��Ϊϡ����������ͼ��ģ
[ci1, sizes1] = components(sparse(NetA));  %cil��ʾ��˳��Ľڵ����ڵڼ���������ͼ sizes����ÿ��������ͼ�ĸ���
n1 = max(sizes1);          %�����ͼ�ĸ���
maxcom1 = find(sizes1==n1);     %�ҳ�������ͼ���ǵڼ�����ͼ
[row1 , col1] =size(maxcom1);    %row1�����������ͼ  col1��������Ϊ1


i=randi([1 row1],1,1);
temp1 = find(ci1==maxcom1(i));  %�ҳ����ڵ�i��������ͨ��ͼ�Ľڵ�
% temp1 = find(ci1==maxcom1(1))%�ҳ����ڵ�1��������ͨ��ͼ�Ľڵ�
num_Lcc1 = length(temp1);%��i��������ͨ��ͼ�Ľڵ����
result1 = num_Lcc1;%������ͨ��ͼ����
if (result1==col1)  %���������ͨ��ͼ����Ϊ1
    G1 = [];%��ÿ����ͨ��ͼ�Ĺ�ģ��Ϊ1��˵��û�м�����ͨ��ͼ����
else
    G1 = temp1;%��ÿ����ͨ��ͼ�Ĺ�ģ��Ϊ1��������ͨ��ͼ�Ľڵ�temp1
end


[ci2, sizes2] = components(sparse(NetB));%ת��Ϊϡ����������ͼ��ģ
n2 = max(sizes2);
maxcom2 = find(sizes2==n2);
[row2 , col2] =size(maxcom2);

j=randi([1 row2],1,1);
temp2 = find(ci2==maxcom2(j));
% temp2 = find(ci2==maxcom2(1));
num_Lcc2 = length(temp2);%һ����ͨ��ͼ�Ľڵ����
result2 = num_Lcc2;
if (result2==col2)
    G2 = [];%��ÿ����ͨ��ͼ�Ĺ�ģ��Ϊ1��˵��û�м�����ͨ��ͼ����
else
    G2 = temp2;
end