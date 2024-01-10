clear;
close all;
clc;
load("dane1D_01_1.mat"); %załadowanie danych pomiarowych i idealnych

N_pom = length(a1);
dt = 0.1;
T = (1:N_pom )* dt;


%macierz przejścia modelu
F = [1 dt 0;
		0 1 dt;
		0 0 1];

% macierz wejścia (sterowania) modelu
G = 0;
u  = 0;

%macierz wyjścia modelu 
H = [0 1 0;
		0 0 1];

%macierz kowariancji szumu pomiarowego
cov_v1 = 1;
cov_a1 = 0.1;

R = [cov_v1^2 0;
		0 cov_a1^2];

%macierz kowariancji szumu przetwarzania
q = [dt dt^2/2;
		1 dt;
		0 1];


W = eye(2) * 0.02;

Q = q * W * q';

estimate_a = zeros(1,N_pom);
estimate_v = zeros(1,N_pom);
estimate_s = zeros(1,N_pom);

%inicjalizacja macierzy X i P
X = [0, 0, 0]';

P = [0 0 0;
		0 0 0;
		0 0 0];

for i = 1:N_pom
	pomiar = [v1_pomiar(i); 
						a1_pomiar(i)];

    [X,P] = Kalman_filter(F, H, Q, G, u, R, pomiar,X, P);
	estimate_s(i) = X(1);
	estimate_v(i) = X(2);
	estimate_a(i) = X(3);
end


% wyniki
figure(1);
hold on;
plot(T, a1, 'b');
plot(T, a1_pomiar, 'g');
plot(T, estimate_a, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie');
grid on;
print("przyspieszenie","-dpng","-r800")


figure(2)
hold on;
plot(T, v1, 'b');
plot(T, v1_pomiar, 'g');
plot(T, estimate_v, 'r');
legend('real','pomiar','estymata');
title('predkosc');
grid on;
print("predkosc","-dpng","-r800")


figure(3)
hold on;
plot(T, s1, 'b');
plot(T, estimate_s, 'r');
legend('real', 'estymata');
title('przemieszczenie');
grid on
print("przemieszczenie","-dpng","-r800")


E_a = 0;
E_v = 0;
E_s = 0;

for i = 1:N_pom
	E_a = E_a + (a1(i)- estimate_a(i))^2;
	E_v = E_v + (v1(i)- estimate_v(i))^2;
	E_s = E_s + (s1(i)- estimate_s(i))^2;
end

disp(['Error s = ', num2str(E_s)])
disp(['Error v = ', num2str(E_v)])
disp(['Error a = ', num2str(E_a)])





