gridsize = 20; % tamaño del mundo
initsize = 20;
step = 150;
rounding = 0; %0, 1 o 2
N = 100; % número de agentes
dt = 0.01; % período de muestreo
T = 10; % tiempo final de simulación

% Definicion de APF (Choset, 2005)
Qi = 5; %Threshold para ignorar obstaculos lejanos
zeta = 5; %Coeficiente de atraccion al goal
eta = 10; %Coeficiente de repulsion a los obstaculos
dstar = 2; %Distancia de threshold para cambiar de funcion conica

%parámetros de APF de Kim, Wang y Shin
c_g = 500; 
l_g = 3;
c_o = 500;
l_o = 0.2;

w = 1; %peso de inercia de los agentes
alpha = 400; %parametro cognitivo
beta = 50; %parametro social
gamma = 35; %Coeficiente de preservacion de diversidad

% Factor de ganancia creado para que ninguna iteracion sea invalida por
% lentitud y los parametros cumplan la misma relacion entre si
K =  0.5; 

behaviour = 1; %  1 multiplicativo, 0 aditivo
choset = 1;
showAPF = 0;
artificialMin = 1;

%Se elige el caso a implementar
Utot = casoA(gridsize,step,rounding,zeta,eta,dstar,Qi,c_g,l_g,c_o,l_o,choset,behaviour,showAPF);

%Se simula 
[histPos,histPot] = simulacion(gridsize,initsize,step,N,T,dt,w,alpha,beta,gamma,K,Utot,artificialMin);

for n = 1:N
figure(1);hold on;grid on
plot(histPos(:,1,n),histPos(:,2,n),'k')
end
figure(5);hold on;grid on
plot(histPot(:,1:N))
histPot(T/dt,1:N);
title('Potencial por agente', 'Interpreter', 'latex', 'Fontsize', 14)
xlabel('iteracion', 'Interpreter', 'latex', 'Fontsize', 12);
ylabel('Potencial', 'Interpreter', 'latex', 'Fontsize', 12);

for n = 1:N
figure(6); hold on; grid on
plot(histPos(:,1,n));
title('Posicion por agente en x', 'Interpreter', 'latex', 'Fontsize', 14)
xlabel('iteracion', 'Interpreter', 'latex', 'Fontsize', 12);
ylabel('Posicion en x', 'Interpreter', 'latex', 'Fontsize', 12);
end
for n = 1:N
figure(7); hold on; grid on
plot(histPos(:,2,n));
title('Posicion por agente en y', 'Interpreter', 'latex', 'Fontsize', 14)
xlabel('iteracion', 'Interpreter', 'latex', 'Fontsize', 12);
ylabel('Posicion en y', 'Interpreter', 'latex', 'Fontsize', 12);
end

% agentes_exitosos = sum((histPot(100,:)<500)==1)
% sum((histPot(1:100,:)<500)==1,2)'
% 
% result = sum((histPot(1:100,:)<500)==1,2)'==agentes_exitosos;
% idx = find(result==1,1)