clc; clear all;

%Уравнение Бюргерса

%параметры задачи
t0=0;
T=0.3;
a=0;
b=1;
eps=0.1;

%ГУ и НУ
Uleft = @ (t) 5;
Uright = @ (t) -2;
Uinit = @ (x) ((2-x)-(x+4)*exp(3*(x-0.25)/eps))/(1+exp(3*(x-0.25)/eps))+3;

% Сетка
N=50; % ось x
M=200; % ось t 
h=(b-a)/N; % шаг по оси x
tau=(T-t0)/M; % шаг по времени

% коэффициент в схеме
% a11=0;
% a11=1;
% a11=1/2;
 a11=(1+i)/2; 
 
x=zeros(1,N+1);
t=zeros(1,M+1);
U=zeros(N+1,M+1);

% сетка по времени
for k=1:M+1
    t(k)=t0+tau*(k-1);
end

% НУ и сетка по x
for k=1:N+1
    x(k)=a+h*(k-1);
    U(k,1)=Uinit(x(k));
end

% вспомогательный массив
for k=1:N+1
    y(k)=U(k,1);
end

% матрица для диффиренциально-алгебраической системы
M_=eye(N+1);
M_(1,1)=0;
M_(N+1,N+1)=0;
for k=1:M
    f=f_pr_ch(y,Uleft,Uright,h,((t(k)+t(k+1))/2),eps);
    fy=yakobian(y,Uleft,Uright,h,t(k),eps);
    W1=(M_-a11*tau*fy)\f;
    for p=1:N+1
    U(p,k+1)=U(p,k)+tau*real(W1(p));
    y(p)=y(p)+tau*real(W1(p));
    end
end

%анимация
for i= 1:1:M+1
    plot(x(1:1:N+1), U(1:1:N+1,1),'r*' ,'LineWidth' , 4 ) ;
    hold on ;
    plot ( x(1:1:N+1) ,U(1 : 1 :N+1,i) ,'-', 'LineWidth' , 3 ) ;
    hold on ;
    title('Решение задачи (уравнение Бюргерса)');
    xlabel ('x' ) ;
    ylabel ('U' ) ;
    txt2 = num2str(i); txt1 = 'Итерация = ';
    txt = [txt1 ' ' txt2] ;
    text(0.7,4.0,txt);
    hold off ;
    drawnow ; 
    pause ( 0.03 ) ;
end