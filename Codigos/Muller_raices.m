% raices teoricas = 3,2,4
clc
format short

error_en_y = 1.0e-8;
error_en_x = 1.0e-8;

% Pueden ser cualquier valor
x1 = 1;
x2 = 1.2;
x3 = 1.5;

encuentre_n_raices = 10;
% crea un vector fila de tamaño n y lo llena de ceros:
raiz = zeros(1, encuentre_n_raices)
n_raices = 0;

%function y = f(x)
%    y = x^3 - 9*x^2 + 25*x*(1 + (sin(x)^2 / 25)) + x / (sec(x)^2) - 24;
%end

function y = f(x)
    y = sin(x);
end

function raiz_i = encuentre_nueva_raiz_muller(x1, x2, x3, n_raices, raiz, error_en_x, error_en_y)
    iteracion = 0;
    while((abs(f(x3)) > error_en_y ) || abs(x3-x2) > error_en_x)
        iteracion = iteracion + 1;
        fprintf("\n");
        fprintf("\n");
        fprintf("------ iteracion # %2.0f ------\n", iteracion);

        Fx1 = f_mayuscula(x1, n_raices, raiz);
        Fx2 = f_mayuscula(x2, n_raices, raiz);
        Fx3 = f_mayuscula(x3, n_raices, raiz);

        fprintf("x1 = %10.6f f(x1) = %10.5e, x2 = %10.6f f(x2) = %10.5e, x3 = %10.6f f(x3) = %10.5e", x1, Fx1, x2, Fx2, x3, Fx3);

        a1 = (Fx3-Fx2) / (x3-x2);
        a2 = (Fx2-Fx1) / (x2-x1);

        a = (a1-a2) / (x3-x1);
        b = a * (x3-x2) + (Fx3-Fx2) / (x3-x2);
        c = Fx3;

        denominador1 = -b - sqrt( b^2 - 4*a*c );
        denominador2 = -b + sqrt( b^2 - 4*a*c );

        if (abs(denominador1) >= abs(denominador2))
            denominador = denominador1;
        else
            denominador = denominador2;
        end

        d = 2*c / denominador;
        x_nuevo = x3 + d; % distancia

        x1 = x2;
        x2 = x3;
        x3 = x_nuevo;
    end
    raiz_i = x3;
end

function mult_x_raiz = mult_x_menos_raiz_i(x, n_raices, raiz)
    mult = 1;
    if (n_raices == 0)
        % nada
    else
        for i = 1:n_raices
            mult = mult * (x-raiz(i));
        end
    end
    mult_x_raiz = mult;
end


function y_mayuscula = f_mayuscula(x, n_raices, raiz)
    y_mayuscula = f(x) / mult_x_menos_raiz_i(x, n_raices, raiz);
end

for i=1:encuentre_n_raices
    x_raiz = encuentre_nueva_raiz_muller(x1, x2, x3, n_raices, raiz, error_en_x, error_en_y);
    fprintf("\nraiz(%2.0f)", i)
    raiz(i) = x_raiz

    n_raices = n_raices + 1;
end