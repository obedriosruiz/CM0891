function [ rutasPro ] = generador( file,  nBuenas, nMalas, grasp)
%UNTITLED2 Summary of this function goes here 
%   Detailed explanation goes here

format bank;
[nVeh,nNod,cap,dist,dem,~] = readData(file); %Data lecture

rutasPro=zeros(nBuenas+nMalas,2*nNod);

for b=1:nBuenas
    [fnOb,rutas]=c23Grasp(grasp(1),grasp(2),grasp(3),file);
    rutasPro(b,1:2*nNod-1)=rutasApro(rutas);
    rutasPro(b,2*nNod)=fnOb;
end
for m=1:nMalas
    rutasPro(nBuenas+m,1:2*nNod-1)=rand(1,2*nNod-1);
    rutasRutas=proArutas(rutasPro(nBuenas+m,1:2*nNod-1));
    rutasPro(nBuenas+m,2*nNod)=calcFnOb(rutasRutas, dist, dem, cap, ...
    nNod,nVeh);
end
end

