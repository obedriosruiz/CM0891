function [ fnObVNS, rutasVNS] = VNS( rutasI, fnObI, dist, cap, dem )
%VNS Variable Neighborhood Search 
 
rutasVNS=rutasI;
fnObVNS=fnObI;
j=1;
while j<=3
    switch j
        case 1
            [rutasAux, fnObAux]=mov1(fnObVNS,dist,rutasVNS);
        case 2
            [rutasAux, fnObAux]=mov3(fnObVNS,dist,rutasVNS,cap,dem);
        %Uncomment for inclusion of movement 2    
%         case 3
%             [rutasAux, fnObAux]=mov2(fnObVNS,dist,rutasVNS,cap,dem);
    end
    if sum(fnObAux)<sum(fnObVNS)
        j=1;
        rutasVNS=rutasAux;
        fnObVNS=fnObAux;
    else
        j=j+1;
    end
end
end