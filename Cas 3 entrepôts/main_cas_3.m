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

beq=[1000 430 1300 110 12 100];
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
x0=[10 36 100 5 5 5 5 5 20 20 35 6 6 63 6 6 30 30 7 7 16 7 7 7];

%% Lancement programme 

options=optimoptions(@fmincon);
options=optimoptions(options,'Display','iter','Plotfcns',@optimplotfval, 'Algorithm','sqp');
resultat=fmincon(@Cout_3,x0,A,b,Aeq,beq,lb,ub,@noncol_cas_3,options);
[a,b]=Cout_3(resultat)


%% Représentation graphique

hold on 

Albi=[13 48];
Castres=[18 12];
Graulhet=[5 30];
Gaillac=[0 45];
Mazamet=[25 0];
Carmaux=[14 62];
Villes=[Albi; Castres; Graulhet; Gaillac; Mazamet; Carmaux];

% Contraintes géographiques :
% - Zone montagneuse
X1=[20 20 70 70];
Y1=[10 40 40 10];

% - Haute Garonne
X2=[-25 -25 10];
Y2=[0 70 0];

% - Tarn
X3=[-20 -20 70 70];
Y3=[0 -20 -20 0];


% Colorer les zones à contrainte
fill(X1,Y1,[255/255 111/255 125/255],X2,Y2, [255/255 111/255 125/255],X3,Y3, [255/255 111/255 125/255],'LineStyle','none') 

%Placement des villes :
plot(Albi(1),Albi(2),"b o")
text(Albi(1)-3,Albi(2)+3,"Albi")

plot(Castres(1),Castres(2),"b o")
text(Castres(1)-3,Castres(2)+3,"Castres")

plot(Gaillac(1),Gaillac(2),"b o")
text(Gaillac(1)-3,Gaillac(2)+3,"Gaillac")

plot(Graulhet(1),Graulhet(2),"b o")
text(Graulhet(1)-3,Graulhet(2)+3,"Graulhet")

plot(Carmaux(1),Carmaux(2),"b o")
text(Carmaux(1)-3,Carmaux(2)+3,"Carmaux")

plot(Mazamet(1),Mazamet(2),"b o")
text(Mazamet(1)-3,Mazamet(2)+3,"Mazamet")

% Cercle de 10km autour d'Albi
th1 = 0:pi/50:2*pi;
x_cercle_albi = 10 * cos(th1) + Albi(1);
y_cercle_albi = 10 * sin(th1) + Albi(2);
h1 = plot(x_cercle_albi,y_cercle_albi ,'b --');

% Cercle de 10km autour de Castres
th2 = 0:pi/50:2*pi;
x_cercle_castres = 10 * cos(th2) + Castres(1);
y_cercle_castres = 10 * sin(th2) + Castres(2);
h2 = plot(x_cercle_castres, y_cercle_castres,'b --');

% Réglage de la fenêtre d'affichage
axis([-20,50,-10,70])

%% Visualisation graphique des solutions
%Entrepôt 1
plot(resultat(1),resultat(2),"*")
text(resultat(1)-3,resultat(2)+3,"Entrepôt 1")
%Entrepôt 2
plot(resultat(9),resultat(10),"*")
text(resultat(9)-3,resultat(10)+6,"Entrepôt 2")
%Entrepôt 3
plot(resultat(17),resultat(18),"*")
text(resultat(17)-3,resultat(18)+6,"Entrepôt 3")

hold off