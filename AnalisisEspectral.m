clear all
%L es el numero de muestras discretas que se han tomado
L = 11705;
%Fs es el periodo  de muestras discretas que se han tomado
Fs = 1000;
%se toman los datos de un archivo en excel
num = xlsread('PortExcel.xlsx');
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
plot(f,P1) 
title('Análisis del espectro de amplitud de la señal del sensor con cuatro pezoneras con tapón')
xlabel('f (Hz)')
ylabel('|P1(f)|')