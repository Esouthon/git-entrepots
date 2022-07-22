clear
%% Bornes lb et ub

lb=zeros(1,24);
lb(1)=-20;
lb(9)=-20;
lb(17)=-20;

ub=5000*ones(1,24);
ub(1)=40;
ub(9)=40;
ub(17)=40;
ub(2)=70;
ub(10)=70;
ub(18)=70;

%% Contrainte linéaire
A=zeros(6,24);

%Contrainte Haute-Garonne Entrepôt 1
A(1,1)=-2;
A(1,2)=-1;
%Contrainte Haute-Garonne Entrepôt 2
A(2,9)=-2;
A(2,10)=-1;
%Contrainte Haute-Garonne Entrepôt 3
A(3,17)=-2;
A(3,18)=-1;
%Contrainte Tarn Entrepôt 1
A(4,2)=-1;
%Contrainte Tarn Entrepôt 2
A(5,10)=-1;
%Contrainte Tarn Entrepôt 3
A(6,18)=-1;


b=[-20;-20;-20;0;0;0];

%% Contrainte d'égualité

beq=[460 430 130 110 100 100];
Aeq=zeros(6,24);

%Somme des livraisons d'Albi
Aeq(1,3)=1;
Aeq(1,11)=1;
Aeq(1,19)=1;

%Somme des livraison Castres
Aeq(2,4)=1;
Aeq(2,12)=1;
Aeq(2,20)=1;

%Somme des livraison Graulet
Aeq(3,5)=1;
Aeq(3,13)=1;
Aeq(3,21)=1;

%Somme des livraison Gaillac
Aeq(4,6)=1;
Aeq(4,14)=1;
Aeq(4,22)=1;

%Somme des livraison Mazamet
Aeq(5,7)=1;
Aeq(5,15)=1;
Aeq(5,23)=1;

%Somme des livraison Carmaux
Aeq(6,8)=1;
Aeq(6,16)=1;
Aeq(6,24)=1;

%% Initialisation 

%X=[x_1 y_1 Albi1 Castres1 Graulet1 Gaillac1 Mazamet1 Carmaux1 x_2 y_2...]

%x0=[10 36 100 5 5 5 5 5 20 20 35 6 6 63 6 6 30 30 7 7 16 7 7 7];

%% Lancement programme 

options=optimoptions(@fmincon);
options=optimoptions(options,'Display','iter','Plotfcns',@optimplotfval, 'Algorithm','sqp');
x0=randi(200,24,1);
fmincon(@Cout_3,x0,A,b,Aeq,beq,lb,ub,@noncol_cas_3,options);


