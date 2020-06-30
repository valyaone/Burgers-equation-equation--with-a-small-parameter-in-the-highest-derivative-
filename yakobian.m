function fy = yakobian(y,Uleft,Uright,h,t,eps)
% y - строчка из начальныхданных
% Uleft - функция на левой границе
% Uright - функция на правой границе
% h - шаг по оси x
% t - точка, в которой нужно посчитать функции
% eps - значение константы в параметре
L = size(y,2);
C=zeros(L);
C(1,1)=1;
C(L,L)=1;
for n=2:L-1
    C(n,n)=-2*eps/(h^2)-(y(n+1)-y(n-1))/(2*h)-1;
    C(n,n-1)=y(n)/(2*h)+eps/(h^2);
    C(n,n+1)=-y(n)/(2*h)+eps/(h^2);
end
fy=C;