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
	a(i) = value;
end

v = zeros(1,400);
s = zeros(1,400);

for k = 2:N_pom
	v(k) = v(k-1) + a(k)*dt; 
	s(k) = s(k-1) + v(k)*dt;
end

a_szum = a + 0.1* randn(1,N_pom);
v_szum = v + 1 * randn(1,N_pom);


figure(1)
subplot(3,1,1)
plot(T,a)
title("a")

subplot(3,1,2)
plot(T,v)
title("v")

subplot(3,1,3)
plot(T,s)
title("s")

figure(2)
plot(T,a)
title("a ")

figure(3)
plot(T,a_szum)
title("a szum")

figure(4)
plot(T,v)
title("v ")

figure(5)
plot(T,v_szum)
title("v szum")

% save("dane.mat","a","v", "s", "a_szum", "v_szum")


