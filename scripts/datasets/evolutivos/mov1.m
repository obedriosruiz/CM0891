function [ rutas, fnOb ] = mov1( fnObAc, dist, rutas )
%mov1 movement 1 

[nVeh,~]=size(rutas);
rutasN=rutas;
fnOb=fnObAc;

for k=1:nVeh
    fnOb(k)=calcFnObV(dist,rutas(k,:));
    i=2;
    while rutas(k,i+1)~=0
        rutasN(k,i)=rutas(k,i+1);
        rutasN(k,i+1)=rutas(k,i);
        fnObAux=calcFnObV(dist,rutasN(k,:));
        if fnObAux<fnOb(k)
            fnOb(k)=fnObAux;
            rutas(k,i)=rutasN(k,i);
            rutas(k,i+1)=rutasN(k,i+1);
            i=1;            
        end       
        i=i+1;
    end    
end
end