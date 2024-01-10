clear;
close all;

amin =  -1;
amax = 1;

dt = 0.1;
N_pom = 1000;
T = (1:N_pom )* dt;

dim  = 3;

%Generowanie przebiegu a
value = amin+rand(1,1)*(amax-amin);
if dim == 1 || dim == 2 || dim == 3
	for i = 1:N_pom
		if mod(i,30) == 0
			value = amin+rand(1,1)*(amax-amin);
		end
		a1(i) = value;
	end
end
if dim == 2 || dim == 3
	for i = 1:N_pom
		if mod(i,30) == 0
			value = amin+rand(1,1)*(amax-amin);
		end
		a2(i) = value;
	end
end
if dim == 3
	for i = 1:N_pom
		if mod(i,30) == 0
			value = amin+rand(1,1)*(amax-amin);
		end
		a3(i) = value;
	end
end

if dim  == 1
	v1 = zeros(1,400);
	s1 = zeros(1,400);
end
if dim  == 2
	v1 = zeros(1,400);
	s1 = zeros(1,400);
	v2 = zeros(1,400);
	s2 = zeros(1,400);
end
if dim  == 3
	v1 = zeros(1,400);
	s1 = zeros(1,400);
	v2 = zeros(1,400);
	s2 = zeros(1,400);
	v3 = zeros(1,400);
	s3 = zeros(1,400);
end


for k = 2:N_pom
	if dim == 1
		v1(k) = v1(k-1) + a1(k)*dt; 
		s1(k) = s1(k-1) + v1(k)*dt;
	end
	if dim == 2
		v1(k) = v1(k-1) + a1(k)*dt; 
		s1(k) = s1(k-1) + v1(k)*dt;
		v2(k) = v2(k-1) + a2(k)*dt; 
		s2(k) = s2(k-1) + v2(k)*dt;
	end
	if dim == 3
		v1(k) = v1(k-1) + a1(k)*dt; 
		s1(k) = s1(k-1) + v1(k)*dt;
		v2(k) = v2(k-1) + a2(k)*dt; 
		s2(k) = s2(k-1) + v2(k)*dt;
		v3(k) = v3(k-1) + a3(k)*dt; 
		s3(k) = s3(k-1) + v3(k)*dt;
	end 
end


if dim == 1
	a_pomiar1 = a1 + 0.1* randn(1,N_pom);
	v_pomiar1 = v1 + 1 * randn(1,N_pom);
end
if dim == 2
	a_pomiar1 = a1 + 0.1* randn(1,N_pom);
	v_pomiar1 = v1 + 1 * randn(1,N_pom);
	a_pomiar2 = a2 + 0.1* randn(1,N_pom);
	v_pomiar2 = v2 + 1 * randn(1,N_pom);
end
if dim == 3
	a_pomiar1 = a1 + 0.1* randn(1,N_pom);
	v_pomiar1 = v1 + 1 * randn(1,N_pom);
	a_pomiar2 = a2 + 0.1* randn(1,N_pom);
	v_pomiar2 = v2 + 1 * randn(1,N_pom);
	a_pomiar3 = a3 + 0.1* randn(1,N_pom);
	v_pomiar3 = v3 + 1 * randn(1,N_pom);
end

if dim == 1
	save("dane1D_01_1.mat","a1","v1", "s1", "a_pomiar1", "v_pomiar1")
end
if dim == 2
	save("dane2D_01_1.mat","a1","v1", "s1", "a_pomiar1", "v_pomiar1", "a2","v2", "s2", "a_pomiar2", "v_pomiar2")
end
if dim == 3
	save("dane3D_01_1.mat","a1","v1", "s1", "a_pomiar1", "v_pomiar1", "a2","v2", "s2", "a_pomiar2", "v_pomiar2","a3","v3", "s3", "a_pomiar3", "v_pomiar3")
end
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
% 
% figure(2)
% hold on
% plot(T,a1, 'r')
% plot(T, a_pomiar1,'g')
% title("a")
% 
% figure(5)
% hold on
% plot(T,v1, 'r')
% plot(T,v_pomiar1,'g')
% title("v")



