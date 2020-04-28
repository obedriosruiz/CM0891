function [ fnOb, rutas ] = MSELS( file, sol, crit1, crit2, nc )
%MSELS Multi-Start Evolutionary Local Search
%   crit1: number of initial solutions to be performed
%   crit2: number of parents to be released 
%   nc   : number of childs
%   file (string) : for example: 'CMT1979//p01.vrp'   

format bank;
[nVeh,nNod,cap,dist,dem,~] = readData(file); %Data lecture

fnOb=inf(nVeh,1);
rutas=zeros(nVeh,nNod+2);

for i=1:crit1
    [rutasAux,fnObAux]=proArutasV(sol(i,:),dist);
    if sum(fnObAux)<sum(fnOb)
        fnOb=fnObAux;
        rutas=rutasAux;
    end    
    for j=1:crit2
        fnObCh=inf(nVeh,1);
        rutasCh=zeros(nVeh,nNod+2);
        for child=1:nc
            [fnObAuxD,rutasAuxD]=perturbarN(2,fnObAux,rutasAux,dist,cap,dem);
            [fnObAuxD,rutasAuxD]=VNS(rutasAuxD,fnObAuxD,dist,cap,dem);
            [rutasAuxD,fnObAuxD]=mov2(fnObAuxD,dist,rutasAuxD,cap,dem);
            if sum(fnObAuxD)<sum(fnObCh)
                fnObCh=fnObAuxD;
                rutasCh=rutasAuxD;
            end
        end
        if sum(fnObCh)<sum(fnObAux)
            fnObAux=fnObCh;
            rutasAux=rutasCh;
        end
    end    
    if sum(fnObAux)<sum(fnOb)
        fnOb=fnObAux;
        rutas=rutasAux;
    end
end
end