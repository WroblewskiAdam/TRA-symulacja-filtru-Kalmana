clc;
clear;
close all;
load("dane1.mat");
load("dane2.mat")
load("dane3.mat")

N_pom = length(a1);
dt = 0.1;
T = (1:N_pom )* dt;

sigma_v1 = 1;
sigma_a1 = 0.1;
sigma_v2 = 1;
sigma_a2 = 0.1;
sigma_v3 = 1;
sigma_a3 = 0.1;

% macierz pomiarow
pomiary = [v_pomiar1; a_pomiar1; v_pomiar2; a_pomiar2; v_pomiar3; a_pomiar3];

% model FK
F = [1 dt dt^2/2 0 0 0 0 0 0;
		0 1 dt 0 0 0 0 0 0;
		0 0 1 0 0 0 0 0 0;
		0 0 0 1 dt dt^2/2 0 0 0;
		0 0 0 0 1 dt 0 0 0 ;
		0 0 0 0 0 1 0 0 0;
		0 0 0 0 0 0 1 dt dt^2/2;
		0 0 0 0 0 0 0 1 dt;
		0 0 0 0 0 0 0 0 1];

G = 0;

H = [0 1 0 0 0 0 0 0 0;
		0 0 1 0 0 0 0 0 0;
		0 0 0 0 1 0 0 0 0;
		0 0 0 0 0 1 0 0 0;
		0 0 0 0 0 0 0 1 0;
		0 0 0 0 0 0 0 0 1];

R = [sigma_v1^2 0 0 0 0 0 ;
		0 sigma_a1^2 0 0 0 0;
		0 0 sigma_v2^2 0 0 0;
		0 0 0 sigma_a2^2 0 0;
		0 0 0 0 sigma_v3^2 0;
		0 0 0 0 0 sigma_a3^2];

q = [dt dt^2/2 0 0 0 0;
		1 dt 0 0 0 0;
		0 1 0 0 0 0;
		0 0 dt dt^2/2 0 0;
		0 0 1 dt 0 0;
		0 0 0 1 0 0;
		0 0 0 0 dt dt^2/2;
		0 0 0 0 1 dt;
		0 0 0 0 0 1];

W = eye(6) * 0.002;

% FK
estimate_a1 = zeros(1,N_pom);
estimate_v1 = zeros(1,N_pom);
estimate_s1 = zeros(1,N_pom);

estimate_a2 = zeros(1,N_pom);
estimate_v2 = zeros(1,N_pom);
estimate_s2 = zeros(1,N_pom);


estimate_a3 = zeros(1,N_pom);
estimate_v3 = zeros(1,N_pom);
estimate_s3 = zeros(1,N_pom);

X_Post= [0, 0, 0, 0, 0, 0, 0, 0, 0]';

P_Post = zeros(9,9);

for i = 1:N_pom
    [X_Post,P_Post] = Kalman_filter(F, G, H, q, W, R, 0, pomiary(:,i), X_Post, P_Post);
	
	estimate_s1(i) = X_Post(1);
	estimate_v1(i) = X_Post(2);
	estimate_a1(i) = X_Post(3);

	estimate_s2(i) = X_Post(4);
	estimate_v2(i) = X_Post(5);
	estimate_a2(i) = X_Post(6);

	estimate_s3(i) = X_Post(7);
	estimate_v3(i) = X_Post(8);
	estimate_a3(i) = X_Post(9);
end


% wyniki
figure(1);
hold on;
plot(T, a1, 'b');
plot(T, a_pomiar1, 'g');
plot(T, estimate_a1, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 1 wym');
grid on;

figure(2)
hold on;
plot(T, v1, 'b');
plot(T, v_pomiar1, 'g');
plot(T, estimate_v1, 'r');
legend('real','pomiar','estymata');
title('predkosc 1 wym');
grid on;

figure(3)
hold on;
plot(T, s1, 'b');
plot(T, estimate_s1, 'r');
legend('real', 'estymata');
title('przemieszczenie 1 wym');
grid on


% wyniki
figure(4);
hold on;
plot(T, a2, 'b');
plot(T, a_pomiar2, 'g');
plot(T, estimate_a2, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 2 wym');
grid on;

figure(5)
hold on;
plot(T, v2, 'b');
plot(T, v_pomiar2, 'g');
plot(T, estimate_v2, 'r');
legend('real','pomiar','estymata');
title('predkosc 2 wym');
grid on;

figure(6)
hold on;
plot(T, s2, 'b');
plot(T, estimate_s2, 'r');
legend('real', 'estymata');
title('przemieszczenie 2 wym');
grid on

% wyniki
figure(7);
hold on;
plot(T, a3, 'b');
plot(T, a_pomiar3, 'g');
plot(T, estimate_a3, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 3 wym');
grid on;

figure(8)
hold on;
plot(T, v3, 'b');
plot(T, v_pomiar3, 'g');
plot(T, estimate_v3, 'r');
legend('real','pomiar','estymata');
title('predkosc 3 wym');
grid on;

figure(9)
hold on;
plot(T, s3, 'b');
plot(T, estimate_s3, 'r');
legend('real', 'estymata');
title('przemieszczenie 3 wym');
grid on




% E_a = 0;
% E_v = 0;
% E_s = 0;
% 
% for i = 1:N_pom
% 	E_a = E_a + (a(i)- estimate_a1(i))^2;
% 	E_v = E_v + (v(i)- estimate_v1(i))^2;
% 	E_s = E_s + (s(i)- estimate_s1(i))^2;
% end




