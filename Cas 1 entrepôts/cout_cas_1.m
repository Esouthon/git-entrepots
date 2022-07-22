function [Cout,M]=cout_cas_1(X)
%% Initilisation 

Albi=[13 48];
Castres=[18 12];
Graulhet=[5 30];
Gaillac=[0 45];
Mazamet=[25 0];
Carmaux=[14 62];
Livraison=[460 430 130 110 100 100];
C_trans=5;
C_depot=5000;

Villes=[Albi; Castres; Graulhet; Gaillac; Mazamet; Carmaux];

Cout=0;
Nb_livr_1=0;

%Matrice 1x10 avec en colonne l'entrepôts, la distance à la ville k, nb total de livraison, le nb
%de livraison par ville, coordonées de l'entrepôt
%| 1  Distance_ville_k  Nb_tot  A  B  C  D  E  F  X  Y|


M=zeros(1,11);
M(1)=1;

%% Calcul du cout de la distance

if sum(Livraison)>1500
    error("erreur de place")
end

for k=1:1:6
    %Liste de la distance d'un entrepôt par rapport à une ville
    Distance_entr_1=Distance(X(1),X(2),Villes(k,:));
    M(1,2)=[Distance_entr_1];
    for j=1:1:Livraison(k)
        Cout=Cout+2*C_trans*M(1,2);
        M(3)=M(3)+1; %On ajoute une livraison au total
        M(k+3)=M(k+3)+1; %On ajoute une livraison à la ville k (avec 3 colonnes de décalage
    end
end
%% Préparation calcul cout entrepôt
%On note les emplacements des entrepôts dans M
M(1,10:11)=[X(1) X(2)];

%% Calcul du coût du dépôt:
%Le nombre total de livraison est infénieur à 500
if M(1,3)<500
    %Condition rayon Albi et Castres
    if (M(1,10)-Albi(1))^2+(M(1,11)-Albi(2))^2<=10^2 || (M(1,10)-Castres(1))^2+(M(1,11)-Castres(2))^2<=10^2
        Cout=Cout+C_depot*2;
    else
        Cout=Cout+C_depot;
    end
%Le nombre total de livraison est entre 500 et 1000
elseif M(1,3)>500 && M(1,3)<1000
%Condition rayon Albi et Castres
if (M(1,10)-Albi(1))^2+(M(1,11)-Albi(2))^2<=10^2 || (M(1,10)-Castres(1))^2+(M(1,11)-Castres(2))^2<=10^2
    Cout=Cout+C_depot*2*1.8;
else
    Cout=Cout+1.8*C_depot;
end
%Le nombre total de livraison est supérieur à 1000
else
    %Condition rayon Albi et Castres
    if (M(1,10)-Albi(1))^2+(M(1,11)-Albi(2))^2<=10^2 || (M(1,10)-Castres(1))^2+(M(1,11)-Castres(2))^2<=10^2
        Cout=Cout+C_depot*2*2.4;
    else
        Cout=Cout+2.4*C_depot;
    end
end
end

   
            
            
     
   
            

