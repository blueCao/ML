%{
SGD£ºstochastic gradient desent
with leargin rate adaptation

z=|sin(t)*x*x|

range:
    x:[-10,10]
    t:[-2*pi,2p]
    z:[0,100]

targe:
    chose a value t, to minize the value z for every x
%}

function [t,gradient_history,learning_rate_history] = function_SGD_rate_adapte(x,z,steps,mini)
    %init t with random value in [-2*pi,2*pi]
    t = 0.51 * pi;
    learning_rate_init = 0.001;
    learning_rate = learning_rate_init;
    max_learning_rate = 0.01;
    min_learning_rate = 0.0001;
    gradient_history=zeros(1,0);
    learning_rate_history=zeros(1,0);
    for i=1:steps
       k = mod(i,size(x,2)) + 1;
       zi = abs(cos(t).*(x.^2));
       gradient = x(1,k)^2 * cos(t);
       gradient_history = [gradient_history,gradient];
       learning_rate_history = [learning_rate_history,learning_rate];
       t = t - learning_rate*gradient;
       zi_1 = abs(sin(t).*(x.^2));
       if abs(gradient) < mini
           disp('finished ! t=')
           disp(t)
           disp('step = ')
           disp(i)
           return 
       end
       %learning rate adapte
       
       %learning rate adapte function 1
       if abs(zi - zi_1) > 0
           learning_rate = learning_rate * 1.05;
       else
           learning_rate = learning_rate * 0.75;
       end
       if learning_rate > max_learning_rate
           learning_rate = max_learning_rate;
       elseif learning_rate < min_learning_rate
           learning_rate = min_learning_rate;
       end
       
       %{
           %learning rate adapte function 2  Annealing:
           learning_rate = learning_rate_init / ( 1 + i / 80000);
       %}
       zi = zi_1;
    end
    disp('step iterator finished!')
    disp(t)
end