function [ rutas,fnOb,time ] = genDuopolio( gener, child, nB, nM, mut, file )
%UNTITLED Summary of this function goes here 
%   Detailed explanation goes here

format bank;
[nVeh,nNod,cap,dist,dem,~] = readData(file); %Data lecture

tic
sol1=generador(file,nB,nM,[1,50,2]);
sol2=generador(file,nB,nM,[1,50,2]);

cont=0;
sln=inf;

for i=1:gener
    hijos1=zeros(child,2*nNod);
    hijos2=zeros(child,2*nNod);
    for j=1:child
        x1=randi(nB+nM);x2=randi(nB+nM);
        y1=randi(nB+nM);y2=randi(nB+nM);
        while x1==y1||x2==y2
           y1=randi(nB+nM);
           y2=randi(nB+nM);
        end
        %Reproduction pob 1
        corte=randi(2*nNod-2);
        if sol1(x1,end)<sol1(y1,end)
            hijos1(j,:)=[sol1(y1,1:corte) sol1(x1,corte+1:2*nNod)];
        else
            hijos1(j,:)=[sol1(x1,1:corte) sol1(y1,corte+1:2*nNod)];
        end       
     
        %Mutation pob 1
        if rand<mut(1)
            pos1=randi(2*nNod-1);
            pos2=randi(2*nNod-1);
            hijos1(j,pos1)=rand;
            hijos1(j,pos2)=rand;
        end
        hijos1(j,2*nNod)=calcFnOb(proArutas(hijos1(j,1:2*nNod-1)),dist,dem,...
            cap,nNod,nVeh);
        
        %Reproduction pob 2
        parX=round(rand(1,2*nNod));
        parY=ones(1,2*nNod)-parX;
        hijos2(j,:)=sol2(x2,:).*parX+sol2(y2,:).*parY;        
        %Mutation pob 2
        if rand<mut(2)
            pos=randi(2*nNod-1);            
            hijos2(j,pos)=rand;            
        end
        hijos2(j,2*nNod)=calcFnOb(proArutas(hijos2(j,1:2*nNod-1)),dist,dem,...
            cap,nNod,nVeh);
    end
    aux1=[sol1;hijos1];
    aux2=[sol2;hijos2];
    [~,sort1]=sort(aux1(:,2*nNod));
    [~,sort2]=sort(aux2(:,2*nNod));
    
    %Poblations update
    for j=1:nB+nM
        sol1(j,:)=aux1(sort1(j),:);
        sol2(j,:)=aux2(sort2(j),:);
    end
    
    %Poblation interaction
    cruzados=1;
    mix1=randperm(nB+nM,cruzados);
    mix2=randperm(nB+nM,cruzados);    
    aCruzar1=zeros(cruzados,2*nNod);
    aCruzar2=zeros(cruzados,2*nNod);    
    for j=1:cruzados
       aCruzar1(j,:)=sol1(mix1(j),:);
       aCruzar2(j,:)=sol2(mix2(j),:);
    end
    sol1(nB+nM-cruzados+1:nB+nM,:)=aCruzar2;
    sol2(nB+nM-cruzados+1:nB+nM,:)=aCruzar1;
    
    %Refreshment
    if cont>=0.05*gener
        sol1(2:nB+nM,:)=generador(file,nB+nM-1,0,[3,2,4]);        
        sol2(2:nB+nM,:)=generador(file,nB+nM-1,0,[3,2,4]);
        for p=1:10
            [rutasAux,fnObAux]=proArutasV(sol1(1+p,:),dist);
            [fnObAux,rutasAux]=VNS(rutasAux,fnObAux,dist,cap,dem);
            sol1(1+p,1:2*nNod-1)=rutasApro(rutasAux);
            sol1(1+p,2*nNod)=sum(fnObAux);
        end
        for p=1:10
            [rutasAux,fnObAux]=proArutasV(sol2(1+p,:),dist);
            [fnObAux,rutasAux]=VNS(rutasAux,fnObAux,dist,cap,dem);
            sol2(1+p,1:2*nNod-1)=rutasApro(rutasAux);
            sol2(1+p,2*nNod)=sum(fnObAux);
        end
        cont=0;
    end
    
    if or(sln(end)==sol1(1,end),sln(end)==sol2(1,end))
      cont=cont+1;      
    else
       cont=0; 
    end
    if sol1(1,2*nNod)<sol2(1,2*nNod)  
        sln=sol1(1,:);
    else  
        sln=sol2(1,:);   
    end
end
[rutasI,fnObI]=proArutasV(sln,dist);
[fnOb,rutas]=VNS(rutasI,fnObI,dist,cap,dem);
time=toc;
end