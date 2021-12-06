:- dynamic campAdverse/2, partieGagnee/2, leCoupEstValideT/3, coordonneesOuListe/3, coupJoueDansGrille/5.
%%%%%%%
% Predicat : minmaxT/4
%Prédicat qui lance la recherche du meilleur coup à jouer
minmaxT(Grille, ListeCoupsNew, Camp, GrilleArr):- 
    minmaxT2(Grille, ListeCoupsNew, 0,Camp, Points),write("retour\n\n"),
    max3(Points, Ind, Points, 0),write("pasla"),write(Ind),nl,
    getInd(ListeCoupsNew, 0, Ind, Coup),write("cc"),
    joueLeCoupMinMaxT(Coup, Camp, Grille, GrilleArr).

minmaxT(Grille, [A|ListeCoupsNew], Camp, GrilleArr):- 
    write(fail),
    joueLeCoupMinMaxT(A, Camp, Grille, GrilleArr),!.

%%%%%%%
% Predicat : minmaxT2/5
%Prédicat récursif pour parcourir tous les coups possibles
minmaxT2(_, [], _, _, _).
minmaxT2(Grille, [A |ListeCoupsNew], PtDeb,Camp, V):- 
    calculCoupT(Grille, A, ListeCoupsNew, PtDeb, Pt, Camp,Camp, 0, 10),
    add_list(Pt, V, Points),write(Points),nl,
    minmaxT2(Grille, ListeCoupsNew, PtDeb, Camp, Points),write("la\n"),!.

%%%%%%%
% Predicat : calculCoupT/7
%Condition de sortie
calculCoupT(_, _, [], _, P, _, _, _, _) :- P is 0.
calculCoupT(_,_,_,_,P,_,_, ProfMax, ProfMax):-P is 0.
%IA gagne
calculCoupT(Grille, [Lettre | Num], _, PointDeb, PointRet, CampA, CampCopaing, _, _) :-
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr), 
    partieGagnee(CampA, GrilleArr),
    get(CampA,CampCopaing),
    get(PointRet, 10), !.
%Joueur gagne
calculCoupT(Grille, [Lettre | Num], _, PointDeb, PointRet, CampA, _, _,_) :-
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr), 
    partieGagnee(CampA, GrilleArr),
    get(PointRet,(-10)),write(PointRet), !.

% Test un coup pour l'IA
calculCoupT(Grille, [Lettre | Num], [_ |_], PointDeb, PointRet, CampA, CampCopaing, ProfInd, ProfMax) :-
    Prof1 is ProfInd + 1,
    ProfInd < ProfMax,
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr),                                    % joue le coup
    tailleListe(Grille, 0, Taille1),
    Taille is Taille1 * Taille1,
    get(CampA,CampCopaing),                                                                           % On regarde qui a joué
    campAdverse(CampB, CampA),                                                                    % On récupère le camp adverse,
    trouveNewCoups(Taille, 0, GrilleArr, [], [0,0], LC2), write(GrilleArr), nl,  % Récupération des nouveaux coups valides
    premierCoup(LC2, B),write(B),nl,
    calculCoupT(GrilleArr, B, LC2, PointDeb, Pt, CampB,CampCopaing, Prof1, ProfMax),                              % Appel récursif
    PointRet is 0 + PointDeb,!.                                                                      % Ajout de points

% Test un coup pour le joueur
calculCoupT(Grille, [Lettre | Num], [_ |_], PointDeb, PointRet, CampA, CampCopaing, ProfInd, ProfMax) :-
    ProfInd < ProfMax,
    Prof1 is ProfInd + 1,
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr),write(GrilleArr), nl,
    tailleListe(Grille, 0, Taille1),
    Taille is Taille1 * Taille1,
    campAdverse(CampA, CampB),
    trouveNewCoups(Taille, 0, GrilleArr, [], [0,0], LC2),
    premierCoup(LC2, B),write(B),nl,
    calculCoupT(GrilleArr, B, LC2, PointDeb, Pt, CampB,CampCopaing, Prof1, ProfMax),
    get(PointRet, 0),!.

%Permet de passer un coup
calculCoupT(Grille, [Lettre | Num], [_ |_], PointDeb, PointRet, CampA, CampCopaing, ProfInd, ProfMax) :-
    ProfInd < ProfMax,
    Prof1 is ProfInd + 1,
    calculCoupT(Grille, [Lettre,Num], [], PointDeb, Pt, CampA,CampCopaing, Prof1, ProfMax),
    get(PointRet, 0).

%%%%%%%
% Predicat : trouveNewCoups/6
%Retourne une liste de coups valides
trouveNewCoups(Taille, Taille, _, A, _, L) :- get(A,L).
trouveNewCoups(Taille, Ind, GrilleDep, A, [Col,Lig], L1):- 
	coupValideL(GrilleDep, Col, Lig, 0, R1),
    get(R1,-),
    extends([Col,Lig], A, L), 
    Ind1 is Ind + 1,
    Taille1 is sqrt(Taille),
    upCase(Taille1, [Col,Lig], Coup1),
    trouveNewCoups(Taille, Ind1, GrilleDep, L, Coup1, L1),!.
trouveNewCoups(Taille, Ind, GrilleDep, A, Coup, L1):- 
    Ind1 is Ind + 1,
    Taille1 is sqrt(Taille),
    upCase(Taille1, Coup, Coup1),
    trouveNewCoups(Taille, Ind1, GrilleDep, A, Coup1, L1),!.
trouveNewCoups(Taille, Ind, GrilleDep, A, Coup, L1):- 
    Ind1 is Ind + 1,
    trouveNewCoups(Taille, Ind1, GrilleDep, A, Coup, L1),!.
%%%%%%%
% Predicat : upCase/3
% Augmente l'indice de parcours d'une liste de cases
upCase(Taille, [C,L], [C,L1]):- L + 1 < Taille, L1 is L + 1, !.
upCase(Taille, [C,_], [C1,0]):- C + 1 < Taille, C1 is C + 1,!.

%%%%%%%
% Predicat : tailleListe/3
%retourne la taille d'une liste
tailleListe([], N, N1) :- get(N,N1).
tailleListe([_|B], N, N1) :- N2 is N + 1, tailleListe(B,N2,N1).

%%%%%%%
% Predicat : joueLeCoupMinMaxT/4
%Joue un coup dans une grille
joueLeCoupMinMaxT(Case, Valeur, GrilleDep, GrilleArr) :-
	coordonneesOuListe(Col, Lig, Case),extract(Lig,Lig1),
	coupJoueDansGrille(Col, Lig1, Valeur, GrilleDep, GrilleArr).
joueLeCoupMinMaxT(Case, Valeur, GrilleDep, GrilleArr) :-
	coordonneesOuListe(Col, Lig, Case),
	coupJoueDansGrille(Col, Lig1, Valeur, GrilleDep, GrilleArr).

%%%%%%%
% Predicat : extract/2
%Extrait une donnée d'une liste d'un élément
extract([A], A).

%%%%%%%
% Predicat : add_list/3
% Ajoute un élément dans une liste (à la fin)
add_list(A, [], [A]).
add_list(A, [B | C], [B | V]) :- add_list(A, C, V).

%%%%%%%
% Predicat : max3/4
%Renvoie l'indice du plus grand élément d'une liste
max3([], _, _, _).
max3([A|B], X, L, Ind) :- max_member(A, L), X is Ind, Ind1 is Ind + 1, max3(B, X, L, Ind1),!.
max3([_|B], X, L, Ind) :- Ind1 is Ind + 1, (max3(B, X,L,Ind1)),!.

%%%%%%%
% Predicat : getInd/4
%Récupère l'élément à l'indice donné dans la liste
getInd([[A,C]|_], Ind, IndV, X) :- Ind == IndV, get([A,C], X),!.
getInd([[_,_]|B], Ind, IndV, X) :- Ind1 is Ind + 1, getInd(B, Ind1, IndV, X).

%%%%%%%
% Predicat : coupValideL/5
%Recherche l'emplacement d'une ligne dans une liste et renvoie l'élément à la colonne donnée
coupValideL([A|_], C, L, L, R1) :- extract2(A, 0, C, R), get(R,R1),!.
coupValideL([_|B], C, L, L1, R1) :- L1 < L, L2 is L1 + 1, coupValideL(B, C, L, L2, R1).

%%%%%%%
% Predicat : extract2/4
%Extrait une colonne d'une ligne
extract2([_|B], C, C1, X) :- C < C1, C2 is C + 1, extract2(B, C2, C1, X).
extract2([A|_], C, C, X) :- get(A,X).

%%%%%%%
% Predicat : get/2
%copie d'un élément
get(A,A).

% Ajout d'une liste dans la liste
extends(Element, List, Extended) :-
    append(List, [Element], Extended).

%Retourne la première liste d'une liste
premierCoup([[A,B]|_], [A,B]).