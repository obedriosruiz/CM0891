function [ fnOb ] = calcFnOb( routes, dist, dem, cap, nNod, nVeh )
%calcFnOb calculates the objective function result for a given route 

fnOb=0;
fnObSum=fnOb;
routesAux=[0 routes];
for i=2:2*nNod
    if routesAux(i)~=0
        fnObSum=fnObSum+dist(routesAux(i-1)+1,routesAux(i)+1);
        fnOb=fnOb+fnObSum;
    else
        fnObSum=0;
    end
end
nVehAux=0;
for i=2:2*nNod-1
    if and(routes(i)==0,routes(i-1)~=0)
        nVehAux=nVehAux+1;
    end
end
fnOb=fnOb+max(nVehAux-nVeh,0)*100000;

carga=0;
for i=1:2*nNod-1
    carga=carga+dem(routes(i)+1);
    if routes(i)==0
        carga=0;
    elseif carga>=cap
        carga=carga+dem(routes(i)+1);
        fnOb=fnOb+50000;
    end
end
end