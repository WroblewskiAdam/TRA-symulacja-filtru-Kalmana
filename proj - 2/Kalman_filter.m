function [X, P] = Kalman_filter (F, H, Q, R, y, X, P)
    X_pred = F*X;
    P_pred = F*P*F' + Q;
    K = P_pred*H'*(H*P_pred*H'+R)^-1;
    X = X_pred + K*(y - H*X_pred);
    P = (eye(length(K*H))-K*H)*P_pred;
end