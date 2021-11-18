:- dynamic minmaxT/4, coupJoueDansGrille/5, leCoupEstValideT/3, coordonneesOuListe/3, partieGagnee/2, toutesLesCasesValides/4, afficheGrille/1.

toutesLesCasesDepartT([[a,1],[a,2],[a,3],[b,1],[b,2],[b,3],[c,1],[c,2],[c,3]]).
%création d'une grille de départ
grilleDeDepartT([[-,-,-],[-,-,-],[-,-,-]]).

%défini la marque pour le cpu
campCPU(x).

%permet d'alterner les tours de jeu
campAdverse(x,o).
campAdverse(o,x).

%fait joué un joueur en vérifiant son coup avant de l'ajouter dans la grille
joueLeCoup(Case, Valeur, GrilleDep, GrilleArr) :-
	coordonneesOuListe(Col, Lig, Case),
	leCoupEstValideT(Col, Lig, GrilleDep),
	coupJoueDansGrille(Col, Lig, Valeur, GrilleDep, GrilleArr),
	nl, afficheGrille(GrilleArr), nl.

% Permet de récupérer un coup joué par l'user (colonne et ligne)
saisieUnCoupT(NomCol,NumLig) :-
	writeln("entrez le nom de la colonne a jouer (a,b,c) :"),
	read(NomCol), nl,
	writeln("entrez le numero de ligne a jouer (1, 2 ou 3) :"),
	read(NumLig),nl.


% Predicat : moteur/3
% Usage : moteur(Grille,ListeCoups,Camp) prend en parametre une grille dans
% laquelle tous les coups sont jouables et pour laquelle
% Camp doit jouer.


% cas gagnant pour le joueur
moteur(Grille,_,Camp):-
	partieGagnee(Camp, Grille), nl,
	write('le camp '), write(Camp), write(' a gagne').

% cas gagnant pour le joueur adverse
moteur(Grille,_,Camp):-
	campAdverse(CampGagnant, Camp),
	partieGagnee(CampGagnant, Grille), nl,
	write('le camp '), write(CampGagnant), write(' a gagne').

% cas de match nul, plus de coups jouables possibles
moteur(_,[],_) :-nl, write('game over').

% cas ou l ordinateur doit jouer
moteur(Grille, [Premier|ListeCoupsNew], Camp) :-
	campCPU(Camp),
	minmaxT(Grille, ListeCoupsNew, Camp, GrilleArr),
	campAdverse(AutreCamp, Camp),
	moteur(GrilleArr, ListeCoupsNew, AutreCamp).

% cas ou c est l utilisateur qui joue
moteur(Grille, ListeCoups, Camp) :-
	campCPU(CPU),
	campAdverse(Camp, CPU),
	saisieUnCoupT(Col,Lig),
	joueLeCoup([Col,Lig], Camp, Grille, GrilleArr),
	toutesLesCasesValides(Grille, ListeCoups, [Col, Lig], ListeCoupsNew),
	moteur(GrilleArr, ListeCoupsNew, CPU).


% Predicat : lanceJeu/0
% Usage :  lanceJeu permet de lancer une partie.
lanceJeu:-
  grilleDeDepartT(G),
	toutesLesCasesDepartT(ListeCoups),
	afficheGrille(G),nl,
   writeln("L ordinateur est les x et vous etes les o."),
   writeln("Quel camp doit debuter la partie ? "),read(Camp),
	toutesLesCasesDepartT(ListeCoups),
	moteur(G,ListeCoups,Camp).