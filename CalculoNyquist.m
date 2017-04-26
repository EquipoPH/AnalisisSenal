clear all
%L es el numero de muestras discretas que se han tomado
L = 823;
%Fs es el periodo  de muestras discretas que se han tomado
Fs = 1000;
%se toman los datos de un archivo en excel
matriz = xlsread('PortExcel.xlsx');

num = matriz(:,3);

%v1 es el vector de las pezoneras sin tapa
v1 = num(1:L,1);

%se hace la transformada de laplace del vector
Y = fft(v1);
%se aidsla la magnitud del espectro 
P2 = abs(Y/L);
%se toma la parte derecha de la magnitud del espectro
P1 = P2(1:L/2+1);
%se multiplica el valor de la sección derecha por dos para compensar la
%partición
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

i = 1;
suma_bajas = 0;
incremental = zeros(size(f));

while(f(i) < 499)
suma_bajas = suma_bajas + P1(i);
incremental(i) = suma_bajas;
i = i + 1;
end

disp(suma_bajas);
disp(sum(P1));

plot(f, incremental)
title('Análisis incremental del espectro de prueba 2 pezoneras con tapa')
xlabel('f (Hz)')
ylabel('Amplitud ')


