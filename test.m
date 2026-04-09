clear 
clc



A=[0	1	0	0
-218756.663497404	-75.3943158453190	0	0
0	0	0	1
0	0	-425015.189785222	-121.227999776810];
Bru=[1.30358515621439e-08	1.30358515745248e-08
0.000161986493696331	0.000161986493698015
-2.26152627580204e-08	2.26152627898945e-08
-0.000238132799911334	0.000238132799917303];
Brf=[-0.00130142918674408
-8.05097234388870
0.00174521761973298
9.47255980317982];
C=[16.0376601050147	0.425434196872911	-35.4185444812321	-0.584329437860915];

M=10^6.*C'*C;
R=10^-6;
aaa=5
A=A+aaa*A.*rand(size(A))
Bru=Bru+aaa*Bru.*rand(size(Bru))
Brf=Brf+aaa*Brf.*rand(size(Brf))
T=0.0001;
T0=5;
[m1,m2]=size([A,Brf,Bru]);
m0=zeros(max(m1,m2));
m0(1:m1,1:m2)=[A,Bru,Brf];
m0=expm(m0*T);
[a1,a2]=size(A);
[b11,b12]=size(Bru);
[b21,b22]=size(Brf);
A0=m0(1:a1,1:a2);
Bu0=m0(1:a1,a2+1:a2+b12);
Bf0=m0(1:a1,a2+b12+1:m2);
B=Bu0;
x_0=4;
u_0=2;
a_0=[x_0,u_0];
c_0=(x_0+u_0)*(x_0+u_0+1)/2;

aerfaa=2;
aerfac=50;
zzz=zeros(1,10);
for i=1:10
    while 1
        wa_0=10*rand(a_0);
        wc_0=10*rand(c_0,1);
        Q2=zeros(1,1000);
        x_01(:,1)=zeros(x_0,1);
        u_01(:,1)=zeros(u_0,1);
        U_01=[x_01;u_01];
        Q0=0;
        for j =1:2000
            u_01(:,j+1)=wa_0'*x_01(:,j);
            Q1=wc_0'*halfl(reshape(kron(U_01(:,j),U_01(:,j)),length(U_01(:,j)),[]));
            %act-critic
            x_01(:,j+1)=A0*x_01(:,j)+B*u_01(:,j+1)+Bf0*(0.5*sin(2*pi*76*j*T)+0.5*sin(2*pi*106*j*T));
            U_01=[x_01;u_01];
            ec_01=Q1-Q0+aerfaa*aerfac*(x_01(:,j+1)'*M*x_01(:,j+1)+aerfaa*aerfac*x_01(:,j)'*M*x_01(:,j))/4;
            Qxx=restore(wc_0(1:x_0*(x_0+1)/2));
            Qxu=aerfaa*aerfac*reshape(wc_0(x_0*(x_0+1)/2+1:x_0*(x_0+1)/2+x_0*u_0),x_0,[]);
            Quu=R;
            ea_01=u_01(:,j+1)+Quu^-1*Qxu'*x_01(:,j+1);
            wa_detla=-aerfaa*(x_01(:,j+1)*ea_01');
            sigama=halfl(reshape(kron(U_01(:,j+1),U_01(:,j+1)),length(U_01(:,j)),[]))-halfl(reshape(kron(U_01(:,j),U_01(:,j)),length(U_01(:,j)),[]));
            wc_detla=-aerfac*(sigama/(1+sigama'*sigama)^2)*ec_01;
            wa_0=wa_0+wa_detla;
            wc_0=wc_0+wc_detla;
            Q0=Q1;
        end
        panduan=isnan(U_01);
        if sum(panduan(:))==0
            break
        end
    end
qqq=abs(C*x_01);
zzz(i)=sum(qqq(:));
if zzz(i)==min(zzz(~ismember(zzz,0)))
    U0=wa_0;
end
end

plot(C*x_01)


   