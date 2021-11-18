%OTHELLO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition de la grille de depart de jeu
% il n y a pas besoin de guillemets pour chaque element de la liste
grilleDeDepart([[-,-,-,-,-,-,-,-],
[-,-,-,-,-,-,-,-],
[-,-,-,-,-,-,-,-],
[-,-,-,o,x,-,-,-],
[-,-,-,x,o,-,-,-],
[-,-,-,-,-,-,-,-],
[-,-,-,-,-,-,-,-],
[-,-,-,-,-,-,-,-]]).

% Garder la possibilite de faire des tests sur une grille plus petite 
grilleTest([[-,-,-],[x,o,-],[-,-,-]]).


% lister toutes les cases disponibles pour jouer
toutesLesCasesDepart([[a,1],[b,1],[c,1],[d,1],[e,1],[f,1],[g,1],[h,1],
		      [a,2],[b,2],[c,2],[d,2],[e,2],[f,2],[g,2],[h,2],
		      [a,3],[b,3],[c,3],[d,3],[e,3],[f,3],[g,3],[h,3],
		      [a,4],[b,4],[c,4],            [f,4],[g,4],[h,4],
		      [a,5],[b,5],[c,5],	        [f,5],[g,5],[h,5],
		      [a,6],[b,6],[c,6],[d,6],[e,6],[f,6],[g,6],[h,6],
		      [a,7],[b,7],[c,7],[d,7],[e,7],[f,7],[g,7],[h,7],
		      [a,8],[b,8],[c,8],[d,8],[e,8],[f,8],[g,8],[h,8]]).



% lister toutes les cases du jeu
toutesLesCases([[a,1],[b,1],[c,1],[d,1],[e,1],[f,1],[g,1],[h,1],
		[a,2],[b,2],[c,2],[d,2],[e,2],[f,2],[g,2],[h,2],
	    [a,3],[b,3],[c,3],[d,3],[e,3],[f,3],[g,3],[h,3],
	    [a,4],[b,4],[c,4],[d,4],[e,4],[f,4],[g,4],[h,4],
	    [a,5],[b,5],[c,5],[d,5],[e,5],[f,5],[g,5],[h,5],
	    [a,6],[b,6],[c,6],[d,6],[e,6],[f,6],[g,6],[h,6],
		[a,7],[b,7],[c,7],[d,7],[e,7],[f,7],[g,7],[h,7],
	    [a,8],[b,8],[c,8],[d,8],[e,8],[f,8],[g,8],[h,8]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : campAdverse/2
% Usage : campAdverse(Camp,campAdverse) permet de trouver le camp advairse d un camp

campAdverse(x,o).
campAdverse(o,x).

% Predicat : campJoueur2/1
% Usage : campJoueur2(CampJ2) est satisfait si CampJ2 est le camp du joueur 2
% Le campJoueur1 est defini dynamiquement en debut de jeu et peut etre modifie en fonction
% du choix des joueurs.
% Permet d associer le nom d un joueur, avec son numero et sa couleur
campJoueur2(CampJ2):-
	campJoueur1(CampJ1),
	campAdverse(CampJ1,CampJ2),!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : saisieUnCoup/2
% Usage : saisieUnCoup(NomCol,NumLig) permet de saisir un coup a jouer

saisieUnCoup(NomCol,NumLig):-
	writeln('Entrez votre coup (sans oublier le point) :'),
 	writeln('Colonne (a, b, c, d, e, f, g ou h) : '),
	saisieColonne(NomCol),
	writeln('Ligne (1, 2, 3, 4, 5, 6, 7 ou 8) : '),
	saisieLigne(NumLig).

% on peut affiner le predicat en testant les valeurs donnees par l utilisateur avec
% saisieColonne et saisieLigne.

% Predicat : saisieColonne/1
% Usage : saisieColonne(NomCol) permet d eviter les erreurs de saisie de la colonne
saisieColonne(NomCol):-
	read(NomCol),
	member(NomCol,[a,b,c,d,e,f,g,h]),!.

saisieColonne(NomCol):-
	writeln('Nom de colonne incorrect'),
	writeln('Colonne (a, b, c, d, e, f, g ou h) : '),
	saisieColonne(NomCol).


% Predicat : saisieLigne/1
% Usage : saisieLigne(NumLig) permet d eviter les erreurs de saisie de la ligne

saisieLigne(NumLig):-
	read(NumLig),
	member(NumLig,[1,2,3,4,5,6,7,8]),!.

saisieLigne(NumLig):-
	writeln('Coup invalide'),
	saisieUnCoup(_NomCol,NumLig).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : lanceJeu/0
% Usage : lanceJeu lance le jeu d othello
lanceJeu:-
	menuPrincipal,!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : menuPrincipal/0
% Usage : menuPrincipal est le menu principal du jeu

menuPrincipal:-
	tab(8),writeln('Menu Principal'),
	tab(8),writeln('--------------'),
	tab(6),writeln('1 - Humain vs Humain'),
	tab(6),writeln('2 - Humain vs CPU'),
	tab(6),writeln('0 - Quitter'),
	saisieChoix(Choix),
	lanceChoix(Choix),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
saisieChoix(Choix):-
	writeln('Choisissez une option (sans oublier le point) : '),
	read(Choix).
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat :saisieNomJoueur1/0
% Usage : saisieNomJoueur1 enregistre le nom du joueur 1 et le rajoute a la base de fait

saisieNomJoueur1:-
	writeln('Entrez le nom du Joueur 1 (sans oublier le point) : '),
	read(J1),
	% Supprime le nom du joueur 1 s il y en avait deja un dans la base de fait :
	%  - retract(P) : recherche une clause dans la base de connaissances qui s unifie avec P
	%        et l efface
	%  - retractall(P) : enleve toutes les clauses qui s unifient a P.
	retractall(nomJoueur1(_X)),
	% Rajoute le nouveau nom du joueur dans la base de fait :
	%  - assert(P) : permet d ajouter P a la base de faits, peut etre ecrit n importe ou
	%  - asserta(P) : ajoute en debut de base
	%  - assertz(P) : ajoute en fin de base
	asserta(nomJoueur1(J1)),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : saisieNomJoueur2
% Usage : saisieNomJoueur2 enregistre le nom du joueur 2
saisieNomJoueur2:-
	writeln('Entrez le nom du Joueur 2 (sans oublier le point) : '),
	read(J2),
	retractall(nomJoueur2(_X)),
	asserta(nomJoueur2(J2)),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : saisieNomCPU
% Usage : saisieNomCPU enregistre le nom de l'ordinateur
saisieNomCPU:-
	writeln('Entrez le nom du CPU (sans oublier le point) : '),
	read(J2),
	retractall(nomJoueur2(_X)),
	asserta(nomJoueur2(J2)),!.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : lanceChoix/1
% Usage : lanceChoix(Choix) lance le choix correspondant au menu principal

%%% choix de sortir du programme
lanceChoix(0):-
	tab(10),writeln('A tres bientot...'),!.

%%% choix de lancer le jeu humain contre humain
lanceChoix(1):-
    % recupere le nom des joueurs et l ajoute dans la BF
	saisieNomJoueur1,
	saisieNomJoueur2,
	% affiche la grille de depart
	afficheGrilleDep,
	grilleDeDepart(Grille),
	% initialise tous les coups disponibles au depart
	toutesLesCasesDepart(ListeCoups),
	nomJoueur1(J1),
	writeln(J1 +' voulez-vous commencer ? o. pour OUI ou n. pour NON : '),
	read(Commence),
	% lance le moteur humain contre humain
	lanceMoteurHH(Grille,ListeCoups, Commence),!.


lanceChoix(2):-
	saisieNomJoueur1,
	saisieNomCPU,
	afficheGrilleDep,
	grilleDeDepart(Grille),
	toutesLesCasesDepart(ListeCoups),
	nomJoueur1(J1),
	writeln(J1 +' voulez-vous commencer ? o. pour OUI ou n. pour NON : '),
	read(Commence).
	%lanceMoteurIA



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Etape 1 : Jeu Humain contre Humain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicat : lanceMoteurHH/3
% Usage : lanceMoteurHH(Grille,ListeCoups,Commence) lance le moteur de jeu 
%   Commence : contient la reponse oui (o) ou non (n) a la question : est-ce que
%   le joueur1 commence
%
% 

/* Lance le moteur de jeu du joueur 1 */

lanceMoteurHH(Grille,ListeCoups,o):-
    % le joueur1 commence, on lui associe les pions 'x' 
    % et on ajoute l information a la base de fait
	retractall(campJoueur1(_X)),
	asserta(campJoueur1(x)),
	campJoueur1(CampJ1),campJoueur2(CampJ2),
	% calcul du score actuel
	score(Grille,CampJ1,ScoreJ1),
	score(Grille,CampJ2,ScoreJ2),
	% on recupere le nom de chaque joueur pour afficher son score
	nomJoueur1(J1),nomJoueur2(J2),
	write(J1),write(' a '),write(ScoreJ1),writeln(' point(s)'),
	write(J2),write(' a '),write(ScoreJ2),writeln(' point(s)'),
	% lance le moteur de jeu pour 'x'
	moteurH1H2(Grille,ListeCoups,CampJ1),!.


/* Lance le moteur du joueur 2 */

lanceMoteurHH(Grille,ListeCoups,n):-
	% le joueur2 commence, on lui associe les pions 'x' 
	% et on associe les 'o' au joueur 1
	retractall(campJoueur1(_X)),
	asserta(campJoueur1(o)),
	campJoueur1(CampJ1),campJoueur2(CampJ2),
	score(Grille,CampJ1,ScoreJ1),
	score(Grille,CampJ2,ScoreJ2),
	nomJoueur1(J1),nomJoueur2(J2),
	write(J1),write(' a '),write(ScoreJ1),writeln(' point(s)'),
	write(J2),write(' a '),write(ScoreJ2),writeln(' point(s)'),
	moteurH2H1(Grille,ListeCoups,CampJ2),!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Moteur du joueur 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicat: moteurH1H2/3
% Usage : moteurH1H2(Grille,ListeCoups,CampJ1) est le moteur de jeu du joueur 1
%

% cas : partie finie
moteurH1H2(Grille,[],CampJ1):-
	campJoueur1(CampJ1),
	moteurHHFin(Grille),!.

% cas : il n y a plus de coups disponibles pour aucun des joueurs - partie finie
moteurH1H2(Grille,ListeCoups,CampJ1):-
	ListeCoups \== [],
	campJoueur1(CampJ1),
	campJoueur2(CampJ2),
	not(testerCoup(ListeCoups,CampJ1,Grille)),
	not(testerCoup(ListeCoups,CampJ2,Grille)),
	moteurHHFin(Grille),!.

% cas : le joueur en cours n a plus de coups disponibles
moteurH1H2(Grille,ListeCoups,CampJ1):-
	nomJoueur1(J1),campJoueur1(CampJ1),campJoueur2(CampJ2),
	not(testerCoup(ListeCoups,CampJ1,Grille)),
	write('Vous devez passer votre tour '),write(J1),write(' ( '),write(CampJ1),writeln(' )'),
	moteurH2H1(Grille,ListeCoups,CampJ2).


% cas : cas general  - le joueur 1 doit jouer 
moteurH1H2(Grille,ListeCoups,CampJ1):-
    % gerer l alternance des coups
	campJoueur1(CampJ1),campJoueur2(CampJ2),nomJoueur1(J1),nomJoueur2(J2),
	% verifier qu il y a bien des coups a jouer
	testerCoup(ListeCoups,CampJ1,Grille),
	% demander la saisie du coup
	write('A vous de jouer '),write(J1),write(' ( '),write(CampJ1),writeln(' )'),
	saisieUnCoup(NomCol,NumLig),
	% jouer le coup dans la grille et mettre a jour la grille
	joueLeCoupDansGrille(CampJ1,[NomCol,NumLig],Grille,GrilleArr),
	% afficher la nouvelle grille
	afficheGrille(GrilleArr),
	% afficher le score de chacun des joueurs
	score(GrilleArr,CampJ1,ScoreJ1),
	score(GrilleArr,CampJ2,ScoreJ2),
	write(J1),write(' a '),write(ScoreJ1),writeln(' point(s)'),
	write(J2),write(' a '),write(ScoreJ2),writeln(' point(s)'),
	write(J1),write(' a joue en ('),write(NomCol),write(','),write(NumLig),writeln(')'),
	% mettre a jour la liste des coups
	duneListeALautre(ListeCoups,[NomCol,NumLig],NouvelleListeCoups),
	% lancer le moteur pour l autre joueur
	moteurH2H1(GrilleArr,NouvelleListeCoups,CampJ2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Moteur du joueur 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicat: moteurH2H1/3
% Usage : moteurH2H1(Grille,ListeCoups,CampJ2) est le moteur de jeu du joueur 2
% Comme si dessus pour le second joueur

moteurH2H1(Grille,[],CampJ2):-
	campJoueur2(CampJ2),
	moteurHHFin(Grille),!.

moteurH2H1(Grille,ListeCoups,CampJ2):-
	ListeCoups \== [],
	campJoueur1(CampJ2),
	campJoueur2(CampJ1),
	not(testerCoup(ListeCoups,CampJ2,Grille)),
	not(testerCoup(ListeCoups,CampJ1,Grille)),
	moteurHHFin(Grille),!.

moteurH2H1(Grille,ListeCoups,CampJ2):-
	nomJoueur2(J2),campJoueur1(CampJ1),campJoueur2(CampJ2),
	not(testerCoup(ListeCoups,CampJ2,Grille)),
	write('Vous devez passer votre tour '),write(J2),write(' ( '),write(CampJ2),writeln(' )'),
	moteurH1H2(Grille,ListeCoups,CampJ1).

moteurH2H1(Grille,ListeCoups,CampJ2):-
	campJoueur1(CampJ1),campJoueur2(CampJ2),nomJoueur1(J1),nomJoueur2(J2),
	testerCoup(ListeCoups,CampJ2,Grille),
	write('A vous de jouer '),write(J2),write(' ( '),write(CampJ2),writeln(' )'),
	saisieUnCoup(NomCol,NumLig),
	joueLeCoupDansGrille(CampJ2,[NomCol,NumLig],Grille,GrilleArr),
	afficheGrille(GrilleArr),
	score(GrilleArr,CampJ1,ScoreJ1),
	score(GrilleArr,CampJ2,ScoreJ2),
	write(J1),write(' a '),write(ScoreJ1),writeln(' point(s)'),
	write(J2),write(' a '),write(ScoreJ2),writeln(' point(s)'),
	write(J2),write(' a joue en ('),write(NomCol),write(','),write(NumLig),writeln(')'),
	duneListeALautre(ListeCoups,[NomCol,NumLig],NouvelleListeCoups),
	moteurH1H2(GrilleArr,NouvelleListeCoups,CampJ1),!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Gestion des fins de parties
%%% Quand il n y a plus de cases libres ou jouables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Predicat : moteurHHFin/1
% Usage : moteurHHFin(Grille)

%% la partie est terminee et c est le joueur 1 qui gagne
moteurHHFin(Grille):-
    campJoueur1(CampJ1),campJoueur2(CampJ2),nomJoueur1(J1),nomJoueur2(J2),
	score(Grille,CampJ1,ScoreJ1),
	score(Grille,CampJ2,ScoreJ2),
	ScoreJ1 > ScoreJ2,
	writeln('La partie est terminee'),
	writeln('Bravo ' + J1 +' vous avez gagne cette partie !!!'),
	writeln('Voulez-vous une revanche, '),write(J2),writeln(' ? (o. pour OUI ou n. pour NON) : '),
	verifSaisie(Revanche),
	lanceRevancheHH(Revanche),!.


%% la partie est terminee et c est le joueur 2 qui gagne
moteurHHFin(Grille):-
	campJoueur1(CampJ1),campJoueur2(CampJ2),nomJoueur1(J1),nomJoueur2(J2),
	score(Grille,CampJ1,ScoreJ1),
	score(Grille,CampJ2,ScoreJ2),
	ScoreJ1 < ScoreJ2,
	writeln('La partie est terminee'),
	writeln('Bravo ' + J2 + 'vous avez gagne cette partie !!!'),
	write('Voulez-vous une revanche, '),write(J1),writeln(' ? (o. pour OUI ou n. pour NON) : '),
	verifSaisie(Revanche),
	lanceRevancheHH(Revanche),!.

%% la partie est terminee et il n y a pas de gagnant
moteurHHFin(Grille):-
	campJoueur1(CampJ1),campJoueur2(CampJ2),
	score(Grille,CampJ1,ScoreJ1),
	score(Grille,CampJ2,ScoreJ2),
	ScoreJ1 = ScoreJ2,
	writeln('La partie est terminee'),
	writeln('Vous etes aussi fort l un que l autre'),
	writeln('Voulez-vous faire une nouvelle partie ? (o. pour OUI ou n. pour NON) : '),
	verifSaisie(Revanche),
	lanceRevancheHH(Revanche),!.


% choix de la fin de partie
% Predicat : lanceRevancheHH/1
% Usage : lanceRevancheHH(Choix)

lanceRevancheHH(o):-
	afficheGrilleDep,
	grilleDeDepart(Grille),
	toutesLesCasesDepart(ListeCoups),
	nomJoueur1(J1),
	writeln(J1 +'voulez-vous commencer ? o. pour OUI ou n. pour NON : '),
	read(Commence),
	lanceMoteurHH(Commence,Grille,ListeCoups),!.

lanceRevancheHH(n):-
	tab(10),writeln('Ca sera peut-etre pour une prochaine fois !'),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% gestion des directions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% indiquer la direction selon la position par rapport à la case en cours C :
%  1  2  3  
%  8  C  4
%  7  6  5
% ce qui donne en se servant de succnum et succ alpha :
% Predicat : caseSuivante/3
% Usage : caseSuivante(Direction,Case,CaseSuivante)

caseSuivante(1,[Colonne,Ligne],[ColonneSuiv,LigneSuiv]):-
	succAlphaO(ColonneSuiv,Colonne),
	succNumO(LigneSuiv,Ligne),!.

caseSuivante(2,[Colonne,Ligne],[Colonne,LigneSuiv]):-
	succNumO(LigneSuiv,Ligne),!.

caseSuivante(3,[Colonne,Ligne],[ColonneSuiv,LigneSuiv]):-
	succAlphaO(Colonne,ColonneSuiv),
	succNumO(LigneSuiv,Ligne),!.

caseSuivante(4,[Colonne,Ligne],[ColonneSuiv,Ligne]):-
	succAlphaO(Colonne,ColonneSuiv),!.

caseSuivante(5,[Colonne,Ligne],[ColonneSuiv,LigneSuiv]):-
	succAlphaO(Colonne,ColonneSuiv),
	succNumO(Ligne,LigneSuiv),!.

caseSuivante(6,[Colonne,Ligne],[Colonne,LigneSuiv]):-
	succNumO(Ligne,LigneSuiv),!.

caseSuivante(7,[Colonne,Ligne],[ColonneSuiv,LigneSuiv]):-
	succAlphaO(ColonneSuiv,Colonne),
	succNumO(Ligne,LigneSuiv),!.

caseSuivante(8,[Colonne,Ligne],[ColonneSuiv,Ligne]):-
	succAlphaO(ColonneSuiv,Colonne),!.


% Predicat : lePionEncadre/4
% Usage : lePionEncadre(Direction,Camp,Grille,Case) verifie qu il existe 
%	  un pion adverse dans une des directions autour du pion 
%     utilise la question 8 pour les direction

lePionEncadre(Direction,Camp,Grille,Case):-
    % on verifie la valeur de la direction
	member(Direction,[1,2,3,4,5,6,7,8]),
	% on parcourt la case suivante dans une direction donnee
	caseSuivante(Direction,Case,[ColonneSuiv,LigneSuiv]),
	% on cherche si il y a un adversaire dans cette position
	campAdverse(Camp,CampAdv),
	caseDeGrilleO(ColonneSuiv,LigneSuiv,Grille,CampAdv),
	% on regarde si il y a bien un pion a 'nous' dans la case suivante
	caseSuivante(Direction,[ColonneSuiv,LigneSuiv],Case3),
	trouvePion(Direction,Camp,Grille,Case3),!.


% Predicat : trouvePion/4
% Usage : trouvePion(Direction,Camp,Grille,Case) verifie que le pion adverse 
%            est bien entoure de l autre cote par un pion du Camp

trouvePion(_Direction,Camp,Grille,[Colonne,Ligne]):-
	caseDeGrilleO(Colonne,Ligne,Grille,Camp),!.
 
trouvePion(Direction,Camp,Grille,[Colonne,Ligne]):-
	campAdverse(Camp,CampAdv),
	caseDeGrilleO(Colonne,Ligne,Grille,CampAdv),
	caseSuivante(Direction,[Colonne,Ligne],CaseSuiv),
	trouvePion(Direction,Camp,Grille,CaseSuiv).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  --> placer le pion ou on veut jouer 
%%%  --> retourner les autres pions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicat : placePionDansLigne/4
% Usage : placePionDansLigne(NomCol,Val,LigneDep,LigneArr) est satisfait si LigneArr
%         peut etre obtenue a partir de LigneDep en jouant le coup valide qui consiste
%         a mettre la valeur Val en NomCol, NumLig.
%	  On suppose donc que le coup que l on desire jouer est valide.

placePionDansLigne(a,Val,[_|SuiteLigneDep],[Val|SuiteLigneDep]):-!.

placePionDansLigne(NomCol,Val,[Tete|SuiteLigneDep],[Tete|SuiteLigneArr]):-
	succAlphaO(Predecesseur,NomCol),
	placePionDansLigne(Predecesseur,Val,SuiteLigneDep,SuiteLigneArr).


% Predicat : placePionDansGrille/5
% Usage : placePionDansGrille(NomCol,NumLig,Val,GrilleDep,GrilleArr) est satisfait
%         si GrilleArr est obtenue a partir de GrilleDep dans laquelle on a joue
%         Val en NomCol, NumLig, et cela etant d autre part un coup valide.

placePionDansGrille(NomCol,1,Val,[Ligne1|SuiteGrille],[Ligne2|SuiteGrille]):-
	placePionDansLigne(NomCol,Val,Ligne1,Ligne2),!.

placePionDansGrille(NomCol,NumLig,Val,[Ligne1|SuiteGrilleDep],[Ligne1|SuiteGrilleArr]):-
	succNumO(Predecesseur,NumLig),
	placePionDansGrille(NomCol,Predecesseur,Val,SuiteGrilleDep,SuiteGrilleArr).



% Predicat : mangePion/5
% Usage : mangePion(Direction,Camp,Grille,GrilleArr,Case) retourne les pions entoures

mangePion(Direction,_Camp,Grille,Grille,Case):-
	not(caseSuivante(Direction,Case,_CaseSuiv)),!.

mangePion(Direction,Camp,Grille,Grille,Case):-
	caseSuivante(Direction,Case,CaseSuiv),
	not(trouvePion(Direction,Camp,Grille,CaseSuiv)),!.

mangePion(Direction,Camp,Grille,Grille,Case):-
	caseSuivante(Direction,Case,[Colonne,Ligne]),
	caseDeGrilleO(Colonne,Ligne,Grille,Camp),!.

mangePion(Direction,Camp,Grille,GrilleArr,Case):-
	caseSuivante(Direction,Case,[Colonne,Ligne]),
	trouvePion(Direction,Camp,Grille,[Colonne,Ligne]),
	campAdverse(Camp,CampAdv),
	caseDeGrilleO(Colonne,Ligne,Grille,CampAdv),
	placePionDansGrille(Colonne,Ligne,Camp,Grille,GrilleProv),
	mangePion(Direction,Camp,GrilleProv,GrilleArr,[Colonne,Ligne]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  --> placer le pion ou on veut jouer 
%%%  --> retourner les autres pions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Predicat : joueLeCoupDansGrille/4
% Usage : joueLeCoupDansGrille(Camp,Coups,Grille,GrilleArr) place le pion 
%         Camp dans la Grille, retourne les pions entoures puis rend 
%         la Grille d arrivee GrilleArr

joueLeCoupDansGrille(Camp,[Colonne,Ligne],Grille,GrilleArr):-
    leCoupEstValideO(Camp,Grille,[Colonne,Ligne]),
	placePionDansGrille(Colonne,Ligne,Camp,Grille,_Grille0),
	mangePion(1,Camp,_Grille0,_Grille1,[Colonne,Ligne]),
	mangePion(2,Camp,_Grille1,_Grille2,[Colonne,Ligne]),
	mangePion(3,Camp,_Grille2,_Grille3,[Colonne,Ligne]),
	mangePion(4,Camp,_Grille3,_Grille4,[Colonne,Ligne]),
	mangePion(5,Camp,_Grille4,_Grille5,[Colonne,Ligne]),
	mangePion(6,Camp,_Grille5,_Grille6,[Colonne,Ligne]),
	mangePion(7,Camp,_Grille6,_Grille7,[Colonne,Ligne]),
	mangePion(8,Camp,_Grille7,GrilleArr,[Colonne,Ligne]),!.
