%{
least mean square error
H-K algorithm
%}
function [w,b,y1,y2]=function_LMSE_HK(x1,x2,b_min,iterator,C)
one=zeros(size(x1,1),1)
one(:,:)=1
x1=[x1,one]
one=zeros(size(x2,1),1)
one(:,:)=1
x2=[x2,one]
x=[x1;-x2]
b_vector_min=zeros(size(x,1),1)
b_vector_min(:,:)=b_min
wk=zeros(size(x,2),1)
wk_1=zeros(size(x,2),1)
bk=zeros(size(x,1),1)
bk_1=zeros(size(x,1),1)
wk(:,:)=1
bk(:,:)=1
found=0
for i=1:iterator
   ek=0.5 .* (x*wk-bk);
   bk_1=bk+2*C*(ek+abs(ek));
   wk_1=inv(x'*x)*x'*bk_1;
   if abs(ek) < b_vector_min
       found=1
       break;
   end
   bk=bk_1;
   wk=wk_1;
end
w=wk_1
b=bk_1
y1=x1*w
y2=x2*w
ek
if abs(ek) < b_vector_min
   fprintf('%s','linear divisible')
else
   fprintf('%s','linear indivisible')
end
