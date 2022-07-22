function [Cout,M]=Cout_cas_2(X)
%% Initilisation 

Albi=[13 48];
Castres=[18 12];
Graulhet=[5 30];
Gaillac=[0 45];
Mazamet=[25 0];
Carmaux=[14 62];
Livraison=[460 430 130 110 100 100];
C_trans=1;
C_depot=5000;

Villes=[Albi; Castres; Graulhet; Gaillac; Mazamet; Carmaux];

Cout=0;
Nb_livr_1=0;
Nb_livr_2=0;

if sum(Livraison)>2*1500
    error("erreur de place")
end



%Matrice 2x10 avec en colonne l'entrepôts, la distance à la ville k, nb total de livraison, le nb
%de livraison par ville, coordonées de l'entrepôt
%| 1  Distance_ville_k  Nb_tot  A  B  C  D  E  F  X  Y|
%| 2  Distance_ville_k  Nb_tot  A  B  C  D  E  F  X  Y|


M=zeros(2,11);
M(:,1)=[1;2];

%% Calcul du cout de la distance


for k=1:1:6
    %Liste de la distance d'un entropôt par rapport à une ville
    Distance_entr_1=Distance(X(1),X(2),Villes(k,:));
    Distance_entr_2=Distance(X(9),X(10),Villes(k,:));
   
    M(:,2)=[Distance_entr_1;Distance_entr_2];
    
    %On trie la matrice pour avoir la liste des entrepôts par ordre
    %croissant de leur distance à la ville k
    %C'est la deuxième colonne avec les distances
    M=sortrows(M,2); 
    
    for j=1:1:Livraison(k)
        %Cas de l'entrepôt le plus proche
        if M(1,3)+1<1500
            Cout=Cout+ 2*C_trans*M(1,2);
            M(1,3)=M(1,3)+1; %On ajoute une livraison au total
            M(1,k+3)=M(1,k+3)+1; %On ajoute une livraison à la ville k (avec 3 colonnes de décalage)
            
        %Cas du deuxième entrepôt le plus proche
        else
            Cout=Cout+ 2*C_trans*M(2,2);
            M(2,3)=M(2,3)+1; %On ajoute une livraison au total
            M(2,k+3)=M(2,k+3)+1;%On ajoute une livraison à la ville k (avec 3 colonnes de décalage)
        end
    end
    %On change de ville, il faut retrier la matrice M par ordre d'entrepôt
    M=sortrows(M,1);
end

%% Préparation calcul cout entrepôt
%On range M par ordre d'entrepôt
M=sortrows(M,1);
%On note les emplacements des entrepôts dans M
M(1,10:11)=[X(1) X(2)];
M(2,10:11)=[X(9) X(10)];

%% Calcul du coût du dépôt:
%Pour le dépôt k
for k=1:1:2
    %Le nombre total de livraison est infénieur à 500
    if M(k,3)<500
        %Condition rayon Albi et Castres
        if (M(k,10)-Albi(1))^2+(M(k,11)-Albi(2))^2<=10^2 || (M(k,10)-Castres(1))^2+(M(k,11)-Castres(2))^2<=10^2
            Cout=Cout+C_depot*2;
        else
            Cout=Cout+C_depot;
        end
              
    %Le nombre total de livraison est entre 500 et 1000
    elseif M(k,3)>500 && M(k,3)<1000
        %Condition rayon Albi et Castres
        if (M(k,10)-Albi(1))^2+(M(k,11)-Albi(2))^2<=10^2 || (M(k,10)-Castres(1))^2+(M(k,11)-Castres(2))^2<=10^2
            Cout=Cout+C_depot*2*1.8;
        else
            Cout=Cout+1.8*C_depot;
        end
    %Le nombre total de livraison est supérieur à 1000
    else
        %Condition rayon Albi et Castres
        if (M(k,10)-Albi(1))^2+(M(k,11)-Albi(2))^2<=10^2 || (M(k,10)-Castres(1))^2+(M(k,11)-Castres(2))^2<=10^2
            Cout=Cout+C_depot*2*2.4;
        else
            Cout=Cout+2.4*C_depot;
        end
    end
end
end

   
            
            
     
   
            

