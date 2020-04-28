function [ fnObM, routesM ] = c23Grasp(crit,itera,nBest,file)
%c23Grasp Method based on a constructive method, where the insertion
%is given by selecting a random node in a list of nBest nodes close to the
%actual node
%
%if crit ~= 3: the method is based on the lowest distances criterion
%if crit == 3: the method is based on the lowest (distance/demand) relation
%   itera    : number of iterations
%   nBest    : length of nearest nodes list considered
%   file (string) : for example: 'CMT1979//p01.vrp' 
format bank;
[nVeh,nNod,cap,dist,dem,~] = readData(file); %Data lecture

fnObM=inf; 

for p=1:itera    
    visited = zeros(1,nNod+1);    %Dinamic matrix of visited nodes
    routes  = zeros(nVeh,nNod+2); %Dinamic matrix of routes per vehicle
    visited(1)=1;
    fnOb=0;
    
    distAux=dist;
    if crit==3            
       for j=2:nNod+1 
           distAux(:,j)=dist(:,j)/dem(j);    %Calculation of matrix 
       end                                   %distances/demands
    end
    ordenMtx=zeros(nNod+1,nNod+1);
    for i=1:nNod+1
       [~,ordenMtx(i,:)]=sort(distAux(i,:)); %Calculation of matrix 
    end
    demAux=dem;
    demAux(1)=inf;
    for k=1:nVeh
        posRut = 2;
        carga  = 0;        
        while carga+min(demAux)<=cap
            i=2;
            u=0;
            nodBest=[];
            while and(i<=nNod+1,length(nodBest)<nBest)
               if (carga+demAux(ordenMtx(routes(k,posRut-1)+1,i)))<=cap 
                   if ~visited(ordenMtx(routes(k,posRut-1)+1,i))
                       nodBest=[nodBest ordenMtx(routes(k,posRut-1)+1,i)];                       
                       u=u+1;
                   end               
               end
               i=i+1;
            end            
            iSel=randi(u);
            pnSel=nodBest(iSel);        
            visited(pnSel)=1;
            carga=carga+demAux(pnSel);
            demAux(pnSel)=inf;
            routes(k,posRut)=pnSel-1;                       
            posRut=posRut+1;
        end
    end   

    for k=1:nVeh 
        i=2;
        %Calculation of objective function result
        while routes(k,i)~=0
            for j=1:i-1
                fnOb=fnOb+dist(routes(k,j)+1,routes(k,j+1)+1);
            end
            i=i+1;
        end            
    end
    if fnOb<fnObM
        fnObM=fnOb;
        routesM=routes;        
    end  
end
