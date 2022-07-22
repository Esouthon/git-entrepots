function [c,ceq]=noncol_cas_1(X)

c=zeros(1,1);

%Position des entrepôts
Entr_1=[X(1) X(2)];

%Vérifie contrainte zone montagneuse Entrepôt 1
if Entr_1(2)>=10 && Entr_1(2)<=40
    c(1)=Entr_1(1)-20;
end

%Absence de contrainte non linéaire d'égalité
ceq=[];
