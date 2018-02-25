%{
fisher transform
%}
function [w,y1,y2]=function_fisher_transform(x1,x2)
m1=mean(x1)'
m2=mean(x2)'
Sw1=zeros(size(x1,2),size(x1,2))
Sw2=zeros(size(x2,2),size(x2,2))
Sw=zeros(size(x2,2),size(x2,2))
for i=1:size(x1,1)
    Sw1=(x1(i,:)' - m1)*(x1(i,:) - m1')
end
Sw1=Sw1/size(x1,1)
for i=1:size(x2,1)
    Sw2=(x2(i,:)' - m2)*(x2(i,:) - m2')
end
Sw2 = Sw2 / size(x2,1)
Sw = Sw1 + Sw2
w = inv(Sw)*(m1-m2)
y1 = x1 * w
y2 = x2 * w