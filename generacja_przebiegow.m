clear;
close all;

amin =  -1;
amax = 1;

dt = 0.1;
N_pom = 1000;
T = (1:N_pom )* dt;

%Generowanie przebiegu a
value = amin+rand(1,1)*(amax-amin);
for i = 1:N_pom
	if mod(i,30) == 0
		value = amin+rand(1,1)*(amax-amin);
	end
	a1(i) = value;
end

v1 = zeros(1,400);
s1 = zeros(1,400);

for k = 2:N_pom
	v1(k) = v1(k-1) + a1(k)*dt; 
	s1(k) = s1(k-1) + v1(k)*dt;
end

a_pomiar1 = a1 + 0.5* randn(1,N_pom);
v_pomiar1 = v1 + 2 * randn(1,N_pom);


% figure(1)
% subplot(3,1,1)
% plot(T,a1)
% title("a")
% 
% subplot(3,1,2)
% plot(T,v1)
% title("v")
% 
% subplot(3,1,3)
% plot(T,s1)
% title("s")

figure(2)
hold on
plot(T,a1, 'r')
plot(T, a_pomiar1,'g')
title("a")

figure(5)
hold on
plot(T,v1, 'r')
plot(T,v_pomiar1,'g')
title("v")

save("dane11.mat","a1","v1", "s1", "a_pomiar1", "v_pomiar1")


