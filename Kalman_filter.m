function [X, P] = Kalman_filter(X,a, pomiar, P, F, H, G, R)
    X_pred = F*X + G*a;
    P_pred = F*P*F';

    K = P_pred*H'*(H*P_pred*H'+R)^-1;
    X = X_pred + K*(pomiar - H*X_pred);
    P = (eye(length(K*H))-K*H)*P_pred*(eye(length((K*H)))-K*H)' + K*R*K';
end