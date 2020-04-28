function [ nVeh, nNod, cap, dist, dem, pos ] = readData(file)
%readData This function reads the data contained in the vrp files and
%calculates the distances between each node. Gives, as result, the
%information as matrix and integers. 
%   Such function is called from the constGen function and it is neccesary
%   to specify the name of the file which has the instances.

data = dlmread(file);  %File
nVeh = data(1,2);                %#Vehicles
nNod = data(1,3);                %#Nodes
cap  = data(2,2);                %Capacity
dem  = data(3:nNod+3,5);         %Demand
pos  = data(3:nNod+3,2:3);

dist=zeros(nNod+1,nNod+1);       %Matrix of distances
%Calculation of euclidean distances 
for i=1:nNod+1
    for j=i+1:nNod+1
        dist(i,j)=sqrt((data(2+i,2)-data(2+j,2))^2+(data(2+i,3)-data(2+j,3))^2);
        dist(j,i)=dist(i,j);
    end
end

end

