function [ rutas ] = proArutas( pro )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here 

rutas=zeros(1,length(pro));
[~,orden]=sort(pro);

nNod=(length(pro)+1)/2;
contC=0;

for i=1:length(orden)
    if and(i-contC==1,orden(i)>nNod)
        contC=contC+1;
    elseif (i-contC~=1&&orden(i)>nNod&&rutas(i-contC-1)==0)
        contC=contC+1;
    elseif orden(i)>nNod
        rutas(i-contC)=0;
    else
        rutas(i-contC)=orden(i);
    end
end
end