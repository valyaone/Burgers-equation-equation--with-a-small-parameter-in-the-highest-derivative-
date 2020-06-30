function f = f_pr_ch(y,Uleft,Uright,h,t,eps)
% y - строчка из начальныхданных
% Uleft - функция на левой границе
% Uright - функция на правой границе
% h - шаг по оси x
% t - точка, в которой нужно посчитать функции
% eps - значение константы в параметре
L = size(y,2);
C=zeros(L,1);
C(1,1)=y(1)-Uleft(t);
for k=2:L-1
    C(k,1)=eps/(h^2)*(y(k+1)-2*y(k)+y(k-1))-y(k)/(2*h)*(y(k+1)-y(k-1))-y(k);
end
C(L,1)=y(L)-Uright(t);
f=C;