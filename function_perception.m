%{
perception algorithm
%}
function [w,y1,y2]=function_perception(x1,x2)
one=zeros(size(x1,1),1)
one(:,:)=1
x1=[x1,one]
one=zeros(size(x2,1),1)
one(:,:)=1
x2=[x2,one]
x=[x1;-x2]
w=zeros(size(x1,2),1)
w(:,:)=1
stop=0
step=0.1
while true
   for i = 1 : size(x,1)
       y = w'*x(i,:)';
       if y <= 0
           stop = 0;
           w = w + step * x(i,:)'
       end
   end
   if stop == 1
       break
   end
   stop = 1;
end
y1 = x1 * w
y2 = x2 * w