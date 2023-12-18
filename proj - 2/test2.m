clc;
clear;
close all;
load("dane.mat");


N_pom = length(a);
dt = 0.1;
T = (1:N_pom )* dt;

sigma_v = 1;
sigma_a = 0.1;

% macierz pomiarow
y = [v_szum;a_szum];

% model FK
A = [1 dt dt^2/2;
		0 1 dt;
		0 0 1];
B = 0;
H = [0 1 0;
    0 0 1];
R = [sigma_v^2 0;
    0 sigma_a^2];
q = [dt dt^2/2;
    1 dt;
    0 1];
W = eye(2) * 0.002;

% FK
xHat = zeros(3,N_pom);
xPost = zeros(3,1);
Ppost = zeros(3,3);
I = eye(3);
for i = 1:N_pom
    [xPost,Ppost] = Kalman_filter(A,B,H,q,W,R,0,y(:,i),xPost,Ppost);
    xHat(:,i) = xPost;
end

% wyniki
figure;
subplot(3,1,1);
plot(T,a_szum,'g');hold on;grid on;
plot(T,a,'r');
plot(T,xHat(3,:),'b');
legend('wzor','pomiar','estymata');
title('przyspieszenie');
subplot(3,1,2);
plot(T,v,'g');hold on;grid on;
plot(T,v_szum,'r');
plot(T,xHat(2,:),'b');
legend('wzor','pomiar','estymata');
title('predkosc');
subplot(3,1,3);
plot(T,s,'g');hold on;grid on;
plot(T,xHat(1,:),'b');
legend('wzor','estymata');
title('przemieszczenie');