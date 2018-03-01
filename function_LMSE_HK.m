%{
least mean square error
H-K algorithm

input：
    x1: 类别1的数据集合，每一行为1个数据
    x2: 类别1的数据集合，每一行为1个数据
    b_min  b的终止阈值
    iterator  迭代的次数  
    C 迭代的因子 0-1之间

output:
    w  迭代求得的w值
    b  迭代求得的b的值
    y1 类别1对应的分类值，值大于0表示类别1，值小于0表示类别2
    y2 类别2对应的分类值，值大于0表示类别1，值小于0表示类别2
%}
function [w,b,y1,y2]=function_LMSE_HK(x1,x2,b_min,iterator,C)
one=zeros(size(x1,1),1);
one(:,:)=1;
x1=[x1,one];
one=zeros(size(x2,1),1);
one(:,:)=1;
x2=[x2,one];
x=[x1;-x2];
b_vector_min=zeros(size(x,1),1);
b_vector_min(:,:)=b_min;
wk=zeros(size(x,2),1);
wk_1=zeros(size(x,2),1);
bk=zeros(size(x,1),1);
bk_1=zeros(size(x,1),1);
wk(:,:)=1;
bk(:,:)=1;
found=0;
divisible=1;
zero=zeros(size(x,1),1);
for i=1:iterator
   ek=0.5 .* (x*wk-bk);
   bk_1=bk+2*C*(ek+abs(ek));
   wk_1=inv(x'*x)*x'*bk_1;
   if abs(ek) < b_vector_min
       found=1;
       fprintf('%s%d\n','interator stop at step ',i)
       break;
   end
   if ek <= zero
       divisible = 0;
       fprintf('%s%d\n','interator stop at step ',i)
       break;
   end
   bk=bk_1;
   wk=wk_1;
end
w=wk_1;
b=bk_1;
y1=x1*w;
y2=x2*w;

if divisible == 0
   fprintf('%s\n','linear indivisible')
   return
end

if abs(ek) < b_vector_min
   fprintf('%s\n','linear divisible')
else
   fprintf('%s\n','iterator finished!')
end