%{
caculate Sw
%}
function Sw1 = function_Sw(x1)
m1=mean(x1)'
Sw1=zeros(size(x1,2),size(x1,2));
for i=1:size(x1,1)
    Sw1=Sw1 + (x1(i,:)' - m1)*(x1(i,:) - m1');
end
Sw1=Sw1/size(x1,1);