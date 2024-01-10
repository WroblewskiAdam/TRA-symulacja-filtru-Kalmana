
clear;
close all;
load("dane11.mat");

N_pom = length(a1);
dt = 0.1;
T = (1:N_pom )* dt;

sigma_v1 = 2;
sigma_a1 = 0.5;

% macierz pomiarow
pomiary = [v_pomiar1; a_pomiar1];

% model FK
A = [1 dt 0;
		0 1 dt;
		0 0 1];

B = 0;

H = [0 1 0;
		0 0 1];

R = [sigma_v1^2 0;
		0 sigma_a1^2];

% q = [dt dt^2/2;
% 		1 dt;
% 		0 1];

q = [0 0;
		0 0;
		0 0];

W = eye(2) * 0.02;


% FK
estimate_a = zeros(1,N_pom);
estimate_v = zeros(1,N_pom);
estimate_s = zeros(1,N_pom);
xHat = zeros(3,N_pom);

X_Post= [0, 0, 0]';

P_Post = [1 1 1;
				1 1 1;
				1 1 1];

for i = 1:N_pom
    [X_Post,P_Post] = Kalman_filter(A, H, q, W, R, pomiary(:,i) ,X_Post, P_Post);
	
	estimate_s(i) = X_Post(1);
	estimate_v(i) = X_Post(2);
	estimate_a(i) = X_Post(3);
end


% wyniki
figure(1);
hold on;
plot(T, a1, 'b');
plot(T, a_pomiar1, 'g');
plot(T, estimate_a, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie');
grid on;

figure(2)
hold on;
plot(T, v1, 'b');
plot(T, v_pomiar1, 'g');
plot(T, estimate_v, 'r');
legend('real','pomiar','estymata');
title('predkosc');
grid on;

figure(3)
hold on;
plot(T, s1, 'b');
plot(T, estimate_s, 'r');
legend('real', 'estymata');
title('przemieszczenie');
grid on

E_a = 0;
E_v = 0;
E_s = 0;

for i = 1:N_pom
	E_a = E_a + (a1(i)- estimate_a(i))^2;
	E_v = E_v + (v1(i)- estimate_v(i))^2;
	E_s = E_s + (s1(i)- estimate_s(i))^2;
end
disp(E_s)



