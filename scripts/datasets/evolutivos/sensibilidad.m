%%
clear;
clc;

data_set = 'CMT1979\\p01.vrp';

arr_gener = 100:50:10000;
tot_iters=length(arr_gener);

for i=1:length(arr_gener)
    [sgolden1.rutas{i},sgolden1.fnOb{i},sgolden1.time{i}] = genDuopolio(arr_gener(i), 5, 4, 7, [0.8,0.7], data_set);
end

%%
fnOb=zeros(1,tot_iters);
time=zeros(1,tot_iters);

for k=1:tot_iters
    fnOb(1,k)=sum(sgolden1.fnOb{k});        
    time(1,k)=sgolden1.time{k};
end

[M,I] = min(fnOb);
%%
close all
figure

subplot(1,2,1);
plot(arr_gener,fnOb)
min_line = yline(min(fnOb), 'b', 'Min : ' + string(min(fnOb)));
max_line = yline(max(fnOb), 'r', 'Max : ' + string(max(fnOb)));
min_line.LabelHorizontalAlignment = 'left';
max_line.LabelHorizontalAlignment = 'right';

dim = [.3 0 .3 .3];
str = 'It = ' + string(I) + ', Gener = ' + string(arr_gener(I));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

title('Sensibilidad sobre parámetro gener')
xlabel('Parámetro')
ylabel('Función objetivo')

subplot(1,2,2);
plot(arr_gener,time)

title('Sensibilidad sobre parámetro gener')
xlabel('Parámetro')
ylabel('Tiempo ejecución (mins)')


