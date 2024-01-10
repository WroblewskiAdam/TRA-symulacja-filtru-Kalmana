clc;
clear;
close all;
load("dane.mat");

state = [0;0];

% v = zeros(1,length(a));
% v_kalman = zeros(1,length(a));
% s = zeros(1,length(a));
% 
% % v_org = zeros(1,length(a));
% % s_org = zeros(1,length(a));
% 
dt = 0.1;
% for k = 2:length(a)
% 	next_state = process_1D(a(k), state);
% 	s(k) = next_state(1,1);
% 	v(k) = next_state(2,1);
% 	state = next_state;
% end

% for k = 2:length(a)
% 	v_org(k) = v_org(k-1) + a(k)*dt; 
% 	s_org(k) = s_org(k-1) + v_org(k)*dt;
% end

var_v = 1;
cov_v = 1;

var_s = 1;
cov_s = 1;

H = [0,1];
P = [var_s, cov_s; cov_v, var_v];
R = 5;
X = [0;0];
F = [ 1 dt; 
		0 1];

G = [0;
		dt];

for k = 2:length(a)
    [X, P] = Kalman_filter(X, a(k), v_szum(k), P, F, H, G, R);
    v_kalman(k) = H*X;
    s_kalman(k) = [1, 0]*X;
end

figure(1)
hold on
plot(v_szum)
plot(v_kalman)
legend('szum', 'kalman')
hold off

figure(2)
hold on
plot(s)
plot(s_kalman)
legend('szum', 'kalman')
hold off


