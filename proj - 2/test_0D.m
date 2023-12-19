
clear;
close all;
load("dane.mat");

N_pom = length(a);
dt = 0.1;
T = (1:N_pom )* dt;

sigma_a = 0.1;

% macierz pomiarow
pomiary = [a_pomiar];

% model FK
A = [1];

B = 0;

H = [1];

R = [sigma_a^2];

q = [1];

W = eye(1) * 0.003;

% FK
estimate_a = zeros(1,N_pom);


X_Post= [0]';

P_Post = [0];

for i = 1:N_pom
    [X_Post,P_Post] = Kalman_filter(A, H, q, W, R, pomiary(:,i) ,X_Post, P_Post);

	estimate_a(i) = X_Post(1);
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





