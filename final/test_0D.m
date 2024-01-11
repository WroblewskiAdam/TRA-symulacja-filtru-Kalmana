clear;
% close all;
clc;
% load("dane1D_01_1.mat"); %załadowanie danych pomiarowych i idealnych

pomiary = ones(1,1000);
pomiary = pomiary + randn(1,1000);

N_pom = length(pomiary);
dt = 0.1;
T = (1:N_pom )* dt;


%macierz przejścia modelu
F = 1;

% macierz wejścia (sterowania) modelu
G = 0;
u  = 0;

%macierz wyjścia modelu 
H = 1;

%macierz kowariancji szumu pomiarowego
cov_a1 = 1;

R = cov_a1;

%macierz kowariancji szumu przetwarzania
q = 0;

W =  5;

Q = q * W * q';

estimate = zeros(1,N_pom);

%inicjalizacja macierzy X i P
X = 0;
P = 1;

for i = 1:N_pom
	pomiar = pomiary(i);

    [X,P] = Kalman_filter(F, H, Q, G, u, R, pomiar,X, P);
	estimate(i) = X;
end


% wyniki
figure(1);
hold on;
plot(T, pomiary, 'b');
plot(T, estimate, 'r');
legend('zaszumione dane','estymata');
title('Odszumianie z wykorzystaniem filtru Kalmana');
grid on;
print("Odszumianie1","-dpng","-r800")


% E_a = 0;
% 
% for i = 1:N_pom
% 	E_a = E_a + (a1(i)- estimate(i))^2;
% end
% disp(['Error a = ', num2str(E_a)])





