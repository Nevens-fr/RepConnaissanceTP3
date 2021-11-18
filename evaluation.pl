:- dynamic succNumT/2, lePionEncadre/4, succAlphaT/2, succNumO/2, succAlphaO/2, donneValeurDeCase/4, donneValeurDeCase/4, donneValeurDeCase/4, toutesLesCasesDepart/1.
% Predicat : ligneDeGrille(NumLigne, Grille, Ligne).
% Satisfait si Ligne est la ligne numero NumLigne dans la Grille
% Le prédicat sert à vérifier si le 3ième paramètre est présent dans la liste au numéro de ligne donné
ligneDeGrille(1, [Test |_], Test).
ligneDeGrille(NumLigne, [_|Reste],Test) :- succNumT(I, NumLigne),
		ligneDeGrille(I,Reste,Test).

% Predicat : leCoupEstValideT/3
% Ce prédicat permet de savoir si une case est libre aux positions données pour le tic tac toe
leCoupEstValideT(C,L,G) :- caseDeGrilleT(C,L,G,-).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : leCoupEstValideO/3
% Usage : leCoupEstValideO(Camp,Grille,Coup) verifie qu il n y a rien dans 
%         la case et que le pion va entoure des pions adverses
% ce qui est equivalent a leCoupEstValide/4 en decomposant le coup en ligne/colonne
leCoupEstValideO(Camp,Grille,[Colonne,Ligne]):-
	caseDeGrilleO(Colonne,Ligne,Grille,-),
	lePionEncadre(_Direction,Camp,Grille,[Colonne,Ligne]),!.

% Predicat : caseDeLigne(Col, Liste, Valeur).
% Satisfait si Valeur est dans la colonne Col de la Liste
% Ce prédicat sert à vérifier si le 3ième paramètre est présent dans la liste à la colonne donnée
caseDeLigne(a, [A|_],A).
caseDeLigne(Col, [_|Reste],Test) :- succAlphaT(I, Col),caseDeLigne(I,Reste, Test).


% Predicat : caseDeGrilleT(NumCol, NumLigne, Grille, Case).
% Satisfait si Case est la case de la Grille en position NumCol-NumLigne
% Ce prédicat permet de tester si un élément est présent dans la grille en position C, L pour le tic tac toe
caseDeGrilleT(C,L,G, Elt) :- ligneDeGrille(L,G,Res),caseDeLigne(C,Res,Elt).


% Predicat : afficheCaseDeGrille(Colonne,Ligne,Grille) .
%afficheCaseDeGrille(1, 2, [['a','b','c'],['c', 'd','e'] ]).
%Affiche une case de la grille
afficheCaseDeGrille(C,L,G) :- caseDeGrilleT(C,L,G,Case),write(Case).

% coordonneesOuListe(NomCol, NumLigne, Liste).
% ?- coordonneesOuListe(a, 2, [a,2]). vrai.
%Renvoi true si le nomCol est dans la liste et que le numliste est également dedanscoordonneesOuListe(a, 2, [a,2]).
coordonneesOuListe(NomCol, NumLigne, [NomCol, NumLigne]).

% duneListeALautre(LC1, Case, LC2)
% ?- duneListeALautre([[a,1],[a,2],[a,3]], [a,2], [[a,1],[a,3]]). est vrai
duneListeALautre([A|B], A, B).
duneListeALautre([A|B], C, [A|D]):- duneListeALautre(B,C,D).

% toutesLesCasesValides(Grille, LC1, C, LC2).
% Se verifie si l'on peut jouer dans la case C de Grille et que la liste
% LC1 est une liste composee de toutes les cases de LC2 et de C.
% Permet de dire si la case C est une case ou l'on peut jouer, en evitant
% de jouer deux fois dans la meme case.
toutesLesCasesValides(Grille, LC1, C, LC2) :-
	coordonneesOuListe(Col, Lig, C),
	leCoupEstValideT(Col, Lig, Grille),
	duneListeALautre(LC1, C, LC2).
%OTHELLO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ligneDansGrille : verifier qu une ligne existe dans une grille;
% caseDansLigne : verifier qu une case existe dans une ligne;
% La methode consiste a tronquer la liste jusqu a arriver a la position qui nous interesse;
% on decremente les index a chaque recursion, 
% la position qui nous interesse est en position 1 ou a.
ligneDansGrille(1,[Tete|_],Tete).
ligneDansGrille(NumLig,[_|Reste],Lig):-
	succNumO(I,NumLig),
	ligneDansGrille(I,Reste,Lig).
caseDansLigne(a,[Tete|_],Tete).
caseDansLigne(Col,[_|Reste],Case):-
	succAlphaO(I,Col),
	caseDansLigne(I,Reste,Case).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat caseDeGrilleO/4
% usage : caseDeGrilleO(NumColonne,NumLigne,Grille,Case) est satisfait si la
%         Case correspond bien a l intersection de la de la colonne NumColonne
%	  et de la ligne NumLigne dans le Grille

caseDeGrilleO(NumColonne,NumLigne,Grille,Case):-
	ligneDansGrille(NumLigne,Grille,Ligne),
	caseDansLigne(NumColonne,Ligne,Case),!.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caseVide(Grille, NumLigne, NumColonne)
% --> vérifier qu une case est vide, cad qu elle contient '-'
caseVide(Grille, NumLigne, NumColonne):-donneValeurDeCase(Grille,NumLigne,NumColonne,-).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : scoreLigne/3
% Usage : scoreLigne(Ligne,Camp,Score) donne le nombre de pion Camp dans
%	  la ligne de grille Ligne

scoreLigne([],_Camp,0):-!.

scoreLigne([Camp|Suite],Camp,Score):-
	scoreLigne(Suite,Camp,Score1),
	Score is Score1 +1.

scoreLigne([Tete|Suite],Camp,Score):-
	Tete \== Camp,
	scoreLigne(Suite,Camp,Score).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : score/3
% Usage : score(Grille,Camp,Score) donne le nombre de pion Camp dans la
%         grille Grille

score([],_Camp,0):-!.

score([Ligne1|Suite],Camp,Score):-
	scoreLigne(Ligne1,Camp,Score1),
	score(Suite,Camp,Score2),
	Score is Score1 + Score2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : listeCasesVides/2
% Usage : listeCasesVides(Grille,ListesCasesLibres) donne a partir
%         d une grille la liste des cases libres

listeCasesVides(Grille,ListeCasesLibres):-
	toutesLesCasesDepart(ListesCases),
	listeCasesLibres(Grille,ListesCases,ListeCasesLibres),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : listeCasesLibres/3
% Usage : listeCasesLibres(Grille,ListeCases,ListeCasesLibres)

listeCasesLibres(_Grille,[],[]):-!.

listeCasesLibres(Grille,[[Colonne,Ligne]|SuiteCases],[[Colonne,Ligne]|SuiteCasesLibres]):-
	caseDeGrilleO(Colonne,Ligne,Grille,-),
	listeCasesLibres(Grille,SuiteCases,SuiteCasesLibres).

listeCasesLibres(Grille,[[Colonne,Ligne]|SuiteCases],SuiteCasesLibres):-
	not(caseDeGrilleO(Colonne,Ligne,Grille,-)),
	listeCasesLibres(Grille,SuiteCases,SuiteCasesLibres).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicat : listeCoupsValides/4
% Usage : listeCoupsValides(ListeCoups,Camp,Grille,ListeCoupsValides) pour un camp

listeCoupsValides([],_Camp,_Grille,[]):-!.

listeCoupsValides([[Colonne,Ligne]|Suite],Camp,Grille,[[Colonne,Ligne]|Suite2]):-
	leCoupEstValideO(Camp,Grille,[Colonne,Ligne]),
	listeCoupsValides(Suite,Camp,Grille,Suite2).

listeCoupsValides([Case|Suite],Camp,Grille,Suite2):-
	not(leCoupEstValideO(Camp,Grille,Case)),
	listeCoupsValides(Suite,Camp,Grille,Suite2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : testerCoup/3
% Usage : testerCoup(ListeCasesVides,Camp,Grille) verifie s il existe
%	  des coups possibles pour le camp Camp dans la Grille, a partir
%	  de la liste des cases vides

testerCoup([[Colonne,Ligne]|Suite],Camp,Grille):-
	leCoupEstValideO(Camp,Grille,[Colonne,Ligne]);
	testerCoup(Suite,Camp,Grille).