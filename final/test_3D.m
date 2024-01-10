clear;
close all;
clc;
load("dane3D_01_1.mat"); %załadowanie danych pomiarowych i idealnych

N_pom = length(a1);
dt = 0.1;
T = (1:N_pom )* dt;


 % pomiary =  [v1_pomiar(i); 
	% 					v2_pomiar(i);
	% 					v3_pomiar(i);
	% 					a1_pomiar(i);
	% 					a2_pomiar(i);
	% 					a3_pomiar(i)];

%macierz przejścia modelu
F = [1 0 0 dt 0 0 dt^2/2 0 0;
		0 1 0 0 dt 0 0 dt^2/2 0;
		0 0 1 0 0 dt 0 0 dt^2/2;
		0 0 0 1 0 0 dt 0 0;
		0 0 0 0 1 0 0 dt 0;
		0 0 0 0 0 1 0 0 dt;
		0 0 0 0 0 0 1 0 0;
		0 0 0 0 0 0 0 1 0;
		0 0 0 0 0 0 0 0 1];

% macierz wejścia (sterowania) modelu
G = 0;
u  = 0;

%macierz wyjścia modelu 
H = [0 0 0 1 0 0 0 0 0;
		0 0 0 0 1 0 0 0 0;
		0 0 0 0 0 1 0 0 0;
		0 0 0 0 0 0 1 0 0;
		0 0 0 0 0 0 0 1 0;
		0 0 0 0 0 0 0 0 1];

%macierz kowariancji szumu pomiarowego
cov_v1 = 1;
cov_a1 = 0.1;
cov_v2 = 1;
cov_a2 = 0.1;
cov_v3 = 1;
cov_a3 = 0.1;

R = [cov_v1^2 0 0 0 0 0 ;
		0 cov_v2^2 0 0 0 0;
		0 0 cov_v3^2 0 0 0;
		0 0 0 cov_a1^2 0 0;
		0 0 0 0 cov_a2^2 0;
		0 0 0 0 0 cov_a3^2];

%macierz kowariancji szumu przetwarzania
q = [dt dt^2/2 0 0 0 0;
		0 0 dt dt^2/2 0 0;
		0 0 0 0 dt dt^2/2;
		1 dt 0 0 0 0;
		0 0 1 dt 0 0;
		0 0 0 0 1 dt;
		0 1 0 0 0 0;
		0 0 0 1 0 0;
		0 0 0 0 0 1];

W = eye(6) * 0.02;

Q = q * W * q';

estimate_a1 = zeros(1,N_pom);
estimate_v1 = zeros(1,N_pom);
estimate_s1 = zeros(1,N_pom);

estimate_a2 = zeros(1,N_pom);
estimate_v2 = zeros(1,N_pom);
estimate_s2 = zeros(1,N_pom);

estimate_a3 = zeros(1,N_pom);
estimate_v3 = zeros(1,N_pom);
estimate_s3 = zeros(1,N_pom);

%inicjalizacja macierzy X i P
X = [0, 0, 0, 0, 0, 0, 0, 0, 0]';

P =  zeros(9,9);

for i = 1:N_pom
   pomiary =  [v1_pomiar(i); 
						v2_pomiar(i);
						v3_pomiar(i);
						a1_pomiar(i);
						a2_pomiar(i);
						a3_pomiar(i)];
	
	[X,P] =  Kalman_filter(F, H, Q, G, u, R, pomiary ,X, P);
	estimate_s1(i) = X(1);
	estimate_s2(i) = X(2);
	estimate_s3(i) = X(3);
	
	estimate_v1(i) = X(4);
	estimate_v2(i) = X(5);
	estimate_v3(i) = X(6);

	estimate_a1(i) = X(7);
	estimate_a2(i) = X(8);
	estimate_a3(i) = X(9);
end


% wyniki 1 wymiar
figure(1);
hold on;
plot(T, a1, 'b');
plot(T, a1_pomiar, 'g');
plot(T, estimate_a1, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 1 wym');
grid on;
print("3D_przyspieszenie_1wym,","-dpng","-r800")


figure(2)
hold on;
plot(T, v1, 'b');
plot(T, v1_pomiar, 'g');
plot(T, estimate_v1, 'r');
legend('real','pomiar','estymata');
title('predkosc 1 wym');
grid on;
print("3D_predkosc_1wym,","-dpng","-r800")


figure(3)
hold on;
plot(T, s1, 'b');
plot(T, estimate_s1, 'r');
legend('real', 'estymata');
title('przemieszczenie 1 wym');
grid on
print("3D_przemieszczenie_1wym,","-dpng","-r800")

% wyniki 2 wymiar
figure(4);
hold on;
plot(T, a2, 'b');
plot(T, a2_pomiar, 'g');
plot(T, estimate_a2, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 2 wym');
grid on;
print("3D_przyspieszenie_2wym,","-dpng","-r800")


figure(5)
hold on;
plot(T, v2, 'b');
plot(T, v2_pomiar, 'g');
plot(T, estimate_v2, 'r');
legend('real','pomiar','estymata');
title('predkosc 2 wym');
grid on;
print("3D_predkosc_2wym,","-dpng","-r800")


figure(6)
hold on;
plot(T, s2, 'b');
plot(T, estimate_s2, 'r');
legend('real', 'estymata');
title('przemieszczenie 2 wym');
grid on
print("3D_przemieszczenie_2wym,","-dpng","-r800")

% wyniki 3 wymiar
figure(7);
hold on;
plot(T, a3, 'b');
plot(T, a3_pomiar, 'g');
plot(T, estimate_a3, 'r');
legend('real','pomiar','estymata');
title('przyspieszenie 3 wym');
grid on;
print("3D_przyspieszenie_3wym,","-dpng","-r800")

figure(8)
hold on;
plot(T, v3, 'b');
plot(T, v3_pomiar, 'g');
plot(T, estimate_v3, 'r');
legend('real','pomiar','estymata');
title('predkosc 3 wym');
grid on;
print("3D_predkosc_3wym,","-dpng","-r800")

figure(9)
hold on;
plot(T, s3, 'b');
plot(T, estimate_s3, 'r');
legend('real', 'estymata');
title('przemieszczenie 3 wym');
grid on
print("3D_przemieszczenie_3wym,","-dpng","-r800")



E_a1 = 0;
E_v1 = 0;
E_s1 = 0;

E_a2 = 0;
E_v2 = 0;
E_s2 = 0;

E_a3 = 0;
E_v3 = 0;
E_s3 = 0;

for i = 1:N_pom
	E_a1 = E_a1 + (a1(i)- estimate_a1(i))^2;
	E_v1 = E_v1 + (v1(i)- estimate_v1(i))^2;
	E_s1 = E_s1 + (s1(i)- estimate_s1(i))^2;

	E_a2 = E_a2 + (a2(i)- estimate_a2(i))^2;
	E_v2 = E_v2 + (v2(i)- estimate_v2(i))^2;
	E_s2 = E_s2 + (s2(i)- estimate_s2(i))^2;

	E_a3 = E_a3 + (a3(i)- estimate_a3(i))^2;
	E_v3 = E_v3 + (v3(i)- estimate_v3(i))^2;
	E_s3 = E_s3 + (s3(i)- estimate_s3(i))^2;
end

disp(['Error s1 = ', num2str(E_s1)])
disp(['Error v1 = ', num2str(E_v1)])
disp(['Error a1 = ', num2str(E_a1)])

disp(['Error s2 = ', num2str(E_s2)])
disp(['Error v2 = ', num2str(E_v2)])
disp(['Error a2 = ', num2str(E_a2)])

disp(['Error s3 = ', num2str(E_s3)])
disp(['Error v3 = ', num2str(E_v3)])
disp(['Error a3 = ', num2str(E_a3)])




