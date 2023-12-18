function [newX,newP] = Kalman_filter (A,B,H,q,W,R,u,y,xPost,pPost)
    Q = q * W * q';
    I = eye(size(A,1));
    % predykcja
    xPrio = A * xPost + B * u;
    pPrio = A * pPost * A' + Q;
    % filtracja
    K = pPrio * H' * (H * pPrio * H' + R)^-1;
    newX = xPrio + K * (y - H * xPrio);
    newP = (I - K * H) * pPrio;
end