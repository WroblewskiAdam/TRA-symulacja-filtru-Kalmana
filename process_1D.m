function [Y] = process_1D(a, X)
	dt = 0.1;
	
	F = [ 1 dt; 
			0 1];

	G = [0;
		dt];

	Y = F*X + G*a;
end

