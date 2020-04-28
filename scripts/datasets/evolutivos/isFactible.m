function [ is ] = isFactible( cap, dem, secRut )
% is Factible, determines if a route is factible given capacity and demands

i=2;
is=0;
carga=0;

while secRut(i)~=0
    carga=carga+dem(secRut(i)+1);
    i=i+1;
end
if carga<=cap
    is=1;
end
end