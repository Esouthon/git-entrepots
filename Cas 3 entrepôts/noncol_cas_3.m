function [c,ceq]=noncol_cas_3(X)

c=zeros(1,6);

%Position des entrepôts
Entr_1=[X(1) X(2)];
Entr_2=[X(9) X(10)];
Entr_3=[X(17) X(18)];

%Vérifie la distance entre l'entrepôt 1 et 2 est supérieur à 10km
c(1)=10-sqrt((Entr_1(1)-Entr_2(1))^2+(Entr_1(2)-Entr_2(2))^2);
%Vérifie la distance entre l'entrepôt 2 et 3 est supérieur à 10km
c(2)=10-sqrt((Entr_2(1)-Entr_3(1))^2+(Entr_2(2)-Entr_3(2))^2);
%Vérifie la distance entre l'entrepôt 1 et 3 est supérieur à 10km
c(3)=10-sqrt((Entr_1(1)-Entr_3(1))^2+(Entr_1(2)-Entr_3(2))^2);

%Vérifie contrainte zone montagneuse Entrepôt 1
if Entr_1(2)>=10 && Entr_1(2)<=40
    c(4)=Entr_1(1)-20;
end
%Vérifie contrainte zone montagneuse Entrepôt 2
if Entr_2(2)>=10 && Entr_2(2)<=40
    c(5)=Entr_2(1)-20;
end
%Vérifie contrainte zone montagneuse Entrepôt 3
if Entr_3(2)>=10 && Entr_3(2)<=40
    c(6)=Entr_3(1)-20;
end
%Absence de contrainte non linéaire d'égalité
ceq=[];
