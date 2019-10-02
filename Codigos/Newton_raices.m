clc
format long

error_en_x = 1.0e-5;
error_en_y = 1.0e-5;

x_inicial = 1;

x = x_inicial;

encuentre_n_raices = 2;
% crea un vector fila de tamaño n y lo llena de ceros:
raiz = zeros(1, encuentre_n_raices)
n_raices = 0;

function y = f(x)
  y = x^2 + 4*x + 4;
end

function raiz_i = encuentre_nueva_raiz_newton(x, n_raices, raiz, error_en_x, error_en_y)
  x_nuevo = x;
  x_viejo = x_nuevo-1;
  iteracion = 0;
  while((abs(f(x)) > error_en_y ) || abs(x_nuevo-x_viejo) > error_en_x)
    iteracion = iteracion + 1;
    fprintf('\n');
    fprintf('\n');
    fprintf('----Iteracion # %2.0f ---- \n', iteracion);
    
    x_viejo = x;
    
    numerador = f_mayuscula(x_viejo, n_raices, raiz);
    
    fprintf("x%1.0f = %25.20e\n", iteracion-1, x_viejo);
    fprintf("f(x%1.0f) = %25.20e\n", iteracion-1, numerador);
    denominador = f_mayuscula_prima(x_viejo, n_raices, raiz);
    
    fprintf("f(x%1.0f) = %25.20e\n", iteracion-1, denominador);
    
    x_nuevo = x - numerador/denominador;
    
    Fx_nuevo = f_mayuscula(x_nuevo, n_raices, raiz);
    fprintf("x%1.0f = %22.18f - %22.18f/%22.18f = %22.18f\n", iteracion, x_viejo, numerador, denominador, x_nuevo);
    fprintf("|f(x%1.0f)| = |%20.16f|\n", iteracion, Fx_nuevo);
    fprintf("|x%1.0f - x%1.0f| = %25.20ef\n", iteracion, iteracion-1, abs(x_nuevo-x_viejo));
    
    x = x_nuevo;
  
  end
  raiz_i = x;
end


function y_mayuscula = f_mayuscula(x, n_raices, raiz)
  y_mayuscula = f(x)/mult_x_menos_raiz_i(x, n_raices, raiz);
end

function y_mayuscula_prima = f_mayuscula_prima(x, n_raices, raiz)
  dx = 1.0e-4;
  x_05 = x + (dx/2);
  x_menos_05 = x - (dx/2);
  F_05 = f_mayuscula(x_05, n_raices, raiz);
  F_menos_05 = f_mayuscula(x_menos_05, n_raices, raiz);
  
  x_1 = x+dx;  
  x_menos_1 = x - dx;
  F_1 = f_mayuscula(x_1, n_raices, raiz);
  F_menos_1 = f_mayuscula(x_menos_1, n_raices, raiz);

  y_mayuscula_prima = (F_05-F_menos_05)/dx;
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

for i=1:encuentre_n_raices
  x_raiz = encuentre_nueva_raiz_newton(x, n_raices, raiz, error_en_x, error_en_y);
  raiz(i) = x_raiz
  fprintf(' raiz(%2.0f) = %10.6f\n', i, raiz(i))  % Para complejos, quitar esta linea
  n_raices = n_raices + 1;
end