function [ proAux ] = rutasApro( rutas )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here 

[nVeh,nNod]=size(rutas);
nNod=nNod-2;

pro=zeros(1,2*nNod);
aux=1;
for k=1:nVeh
    i=2;
    while rutas(k,i)~=0
        i=i+1;
    end
    pro(aux:aux+i-2)=rutas(k,2:i);
    aux=aux+i-1;
end
pro=pro(1:2*nNod-1);

cont=0;
proAux=zeros(1,2*nNod-1);
for i=1:2*nNod-1
    if pro(i)~=0
        proAux(pro(i))=i/(2*nNod-1);
    else
        if nNod+1+cont>2*nNod-1
         	pos=find(not(proAux)); 
            proAux(pos)=rand;
        else
            proAux(nNod+1+cont)=i/(2*nNod-1);
            cont=cont+1;
        end        
    end
end
end

