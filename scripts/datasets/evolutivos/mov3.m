function [ rutas, fnOb ] = mov3( fnObAc, dist, rutas, cap, dem )
%mov3 movement 3 

[nVeh,nNod]=size(rutas);
fnOb=fnObAc;

k=1;
while k<=nVeh  
   rutasN=rutas;
   i=2;
   nodSel=i;
   while rutas(k,i+1)~=0
       if dist(rutas(k,i)+1,rutas(k,i+1)+1)>dist(rutas(k,nodSel)+1,...
               rutas(k,nodSel+1)+1)
           nodSel=i;
       end
       i=i+1;
   end
   rutasN(k,nodSel:nNod-1)=rutas(k,nodSel+1:nNod);
   rutasNAux=rutasN;
   for j=1:nVeh
       pose=find(rutas(j,:));
       if ~isempty(pose)
           if j~=k
               rutasNAux(j,pose(length(pose))+1)=rutas(k,nodSel);
               fnObAux(1)=calcFnObV(dist,rutasNAux(k,:));
               fnObAux(2)=calcFnObV(dist,rutasNAux(j,:));
               is=isFactible(cap, dem, rutasNAux(j,:));
               if and(sum(fnObAux)<fnOb(k)+fnOb(j),is)
                   rutas=rutasNAux;
                   fnOb(k)=fnObAux(1);
                   fnOb(j)=fnObAux(2);
                   k=nVeh+1;
                   break;
               else
                   rutasNAux=rutasN;
               end
           end
       end
   end
   k=k+1;
end
end