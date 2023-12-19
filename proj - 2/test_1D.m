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
pomiary = [v_pomiar; a_pomiar];

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
estimate_a = zeros(1,N_pom);
estimate_v = zeros(1,N_pom);
estimate_s = zeros(1,N_pom);
xHat = zeros(3,N_pom);

X_Post= [0, 0, 0]';

P_Post = [0 0 0;
				0 0 0;
				0 0 0];

for i = 1:N_pom
    [X_Post,P_Post] = Kalman_filter(A, B, H, q, W, R, 0, pomiary(:,i) ,X_Post, P_Post);
	
	estimate_s(i) = X_Post(1);
	estimate_v(i) = X_Post(2);
	estimate_a(i) = X_Post(3);
end


% wyniki
figure(1);
hold on;
plot(T, a, 'b');
plot(T, a_pomiar, 'g');
plot(T, estimate_a, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie');
grid on;

figure(2)
hold on;
plot(T, v, 'b');
plot(T, v_pomiar, 'g');
plot(T, estimate_v, 'r');
legend('real','pomiar','estymata');
title('predkosc');
grid on;

figure(3)
hold on;
plot(T, s, 'b');
plot(T, estimate_s, 'r');
legend('real', 'estymata');
title('przemieszczenie');
grid on

E_a = 0;
E_v = 0;
E_s = 0;

for i = 1:N_pom
	E_a = E_a + (a(i)- estimate_a(i))^2;
	E_v = E_v + (v(i)- estimate_v(i))^2;
	E_s = E_s + (s(i)- estimate_s(i))^2;
end




