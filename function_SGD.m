%{
SGD£ºstochastic gradient desent
z=|sin(t)*x*x|

range:
    x:[-10,10]
    t:[-2*pi,2p]
    z:[0,100]

targe:
    chose a value t, to minize the value z for every x
%}

function [t,gradient_history,learning_rate_history] = function_SGD(x,z,steps,mini)
    %init t with random value in [-2*pi,2*pi]
    t = 0.51 * pi;
    gradient_history=zeros(1,0);
    for i=1:steps
       k = mod(i,size(x,2)) + 1;
       zi = abs(cos(t).*(x.^2));
       gradient = x(1,k)^2 * cos(t);
       gradient_history = [gradient_history,gradient];
       t = t - 0.001*gradient;
       zi_1 = abs(sin(t).*(x.^2));
       if abs(gradient) < mini
           disp('finished ! t=')
           disp(t)
           disp('step = ')
           disp(i)
           return 
       end
       zi = zi_1;
    end
    disp('step iterator finished!')
    disp(t)
end