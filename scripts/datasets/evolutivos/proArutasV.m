function [ rutasV, fnObV ] = proArutasV( pro,dist)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
nNod=length(pro)/2;
rutasF=proArutas(pro(1:2*nNod-1));

nVeh=0;

for i=2:2*nNod-1
   if and(rutasF(i)==0,rutasF(i-1)~=0)
       nVeh=nVeh+1;
   end
end

rutasV=zeros(nVeh,nNod+2);
fnObV=zeros(nVeh,1);

k=1;
j=2;
for i=1:2*nNod-1
    if rutasF(i)~=0
        rutasV(k,j)=rutasF(i);
        j=j+1;
    elseif and(rutasF(i)==0,rutasF(i-1)~=0)
        k=k+1;
        j=2;
    end
end

for k=1:nVeh
   fnObV(k)=calcFnObV(dist,rutasV(k,:));
end
end

