clc
x = [1 2];
y = [56.1 78.6];

%n = 3;    % grado del polinomio
p = 1.5;   % El polinomio se evalua en p (valor a hallar)

function suma = lagrange(x, y, p)
    % Calcule P(p)
    n = length(x) - 1;
    suma = 0;
    for k=1:1:n+1
        ter_sig = (multiplique(k, n, p, x))*y(k);
        suma = suma + ter_sig;
    end
end

function multiplicacion = multiplique(k, n, xx, x)
    multiplicacion = 1;
    for i=1:1:n+1
        if (i == k)
            %nada
        else
            ter_sig = (xx - x(i)) / (x(k) - x(i));
            multiplicacion = multiplicacion * ter_sig;
        end
    end
end

lagrange(x, y, p)




