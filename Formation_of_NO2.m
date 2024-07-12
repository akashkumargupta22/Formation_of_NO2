% -> Initial Conditions:-
    k_1 = 38;                % -> Coefficient value k1
    k_2 = 400;               % -> Coefficient value k2
    
    F2_rk(1) = 1;            % -> Initial value for F2_rk
    NO2_rk(1) = 1;           % -> Initial value for NO2_rk
    F_rk(1) = 0;             % -> Initial value for F_rk
    NO2F_rk(1) = 0;          % -> Initial value for NO2F_rk
    F2_exp(1) = 1;           % -> Initial value for F2_exp
    NO2_exp(1) = 1;          % -> Initial value for NO2_exp
    F_exp(1) = 0;            % -> Initial value for F_exp
    NO2F_exp(1) = 0;         % -> Initial value for NO2F_exp
    h = 0.0001;              % -> Step size

% -> Explicit method loop
    for i = 1:2000
        F2_exp(i+1) = F2_exp(i) + h * d1(F2_exp(i), NO2_exp(1));
        F_exp(i+1) = F_exp(i) + h * d2(F2_exp(i), NO2_exp(1), F_exp(i));
        NO2F_exp(i+1) = NO2F_exp(i) + h * d3(F2_exp(i), NO2_exp(1), F_exp(i));
    end

% -> Runge-Kutta method loop
    for i = 1:2000
        k1(1) = d1(F2_rk(i), NO2_rk(1));
        k2(1) = k1(1) + (h/2) * k1(1);
        k3(1) = k1(1) + (h/2) * k2(1);
        k4(1) = k1(1) + h * k3(1);
    
        k1(2) = d2(F2_rk(i), NO2_rk(1), F_rk(i));
        k2(2) = k1(2) + (h/2) * k1(2);
        k3(2) = k1(2) + (h/2) * k2(2);
        k4(2) = k1(2) + h * k3(2);
    
        k1(3) = d3(F2_rk(i), NO2_rk(1), F_rk(i));
        k2(3) = k1(3) + (h/2) * k1(3);
        k3(3) = k1(3) + (h/2) * k2(3);
        k4(3) = k1(3) + h * k3(3);
    
        F2_rk(i+1) = F2_rk(i) + (h/6) * (k1(1) + 2*k2(1) + 2*k3(1) + k4(1));
        F_rk(i+1) = F_rk(i) + (h/6) * (k1(2) + 2*k2(2) + 2*k3(2) + k4(2));
        NO2F_rk(i+1) = NO2F_rk(i) + (h/6) * (k1(3) + 2*k2(3) + 2*k3(3) + k4(3));
    end
% Graph Plotting:-
    
    figure(1)
    plot(F2_exp,'g');
    hold on
    plot(NO2F_exp,'r');
    figure(2)
    plot(F2_rk,'b');
    hold on
    plot(NO2F_rk,'c');
    figure(3)
    plot(NO2F_rk);
    hold on
    plot(NO2F_exp);

% Different Functions used:-
    function f = d1(a, b)
        f = -38 * a * b^2;
    end
    
    function f = d2(a, b, c)
        f = 38 * a * b^2 - 400 * c * b;
    end
    
    function f = d3(a, b, c)
        f = 38 * a * b^2 + 400 * c * b;
    end
