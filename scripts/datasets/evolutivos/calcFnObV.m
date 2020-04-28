function [ secFnOb ] = calcFnObV( dist, secRut )
%calcFnOb calculates the objective function result for a given route

i=2;
secFnOb=0;

while secRut(i)~=0
    for j=1:i-1
        secFnOb=secFnOb+dist(secRut(j)+1,secRut(j+1)+1);
    end
    i=i+1;
end        
end