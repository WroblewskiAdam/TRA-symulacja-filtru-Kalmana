clc;
clear;
close all;
load("dane.mat");

state = [0;0];

v = zeros(1,length(a));
s = zeros(1,length(a));

v_org = zeros(1,length(a));
s_org = zeros(1,length(a));

dt = 0.1;
for k = 2:length(a)
	next_state = process_1D(a(k), state);
	s(k) = next_state(1,1);
	v(k) = next_state(2,1);
	state = next_state;
end

for k = 2:length(a)
	v_org(k) = v_org(k-1) + a(k)*dt; 
	s_org(k) = s_org(k-1) + v_org(k)*dt;
end

var_v = var(v);
cov_v = cov(v, s);

var_a = var(s);
cov_a = cov(s,v);


P = [variance_v]