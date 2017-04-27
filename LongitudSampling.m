%Se importan los datos de Excel
%La primera columna son los tiempos del voltaje del sensor
%La segunda son los valores de voltaje
%La tercera son lso valores de tiempo del tracker
%La cuarta son los valores de flujo sacados por tracker

clear all
num = xlsread('PortExcel.xlsx');
tiempos_voltaje_original = num(:,1);
voltaje_original = num(:,2);
tiempos_tracker = num(:,3);
tracker_original = num(:,4);


%se crean nuevos vectores para los tiempos
t_volt = tiempos_voltaje_original;
t_tracker = tiempos_tracker;
tracker_data = tracker_original;


%Recorte de valores picos del voltaje 
for i = 1:size(voltaje_original,1)
    if (voltaje_original(i) < 0)
        voltaje_original(i) = 0; 
    end  
    if (voltaje_original(i) > 1)
        voltaje_original(i) = 1; 
    end  
end



%Filtro de promedios para voltaje
windowSize = 20; 
b1 = (1/windowSize)*ones(1,windowSize);
a1 = 1;
voltaje_filtrado = filter(b1,a1,voltaje_original);


%Se modifica el vector de tiempo para eliminar la sección inicial
for i = 1:size(voltaje_filtrado,1)
    if (voltaje_filtrado(i)>0.1)
        recortada = voltaje_filtrado(i:end);
        t_rec_volt = t_volt(i:end);
        break
    end  
end

t_rec_volt = t_rec_volt - t_rec_volt(1);

%filtro promedios para tracker
windowSize = 10; 
b2 = (1/windowSize)*ones(1,windowSize);
a2 = 1;
v2 = filter(b2,a2, tracker_data); 

%Se modifica el vector de tiempo apra eliminar la sección inicial
for i = 1:size(v2,1)
    if (v2(i)>0.1)
        recortada_trak = v2(i:end);
        t_rec_trak = t_tracker(i:end);
        break
    end  
end

t_rec_trak = t_rec_trak - t_rec_trak(1);


%Se grafican los datos

plot(t_rec_volt,recortada)
hold on
plot(t_rec_trak, recortada_trak)

title('Primera prueba con válvula')
xlabel('t(s)')
ylabel('V y m/s')


