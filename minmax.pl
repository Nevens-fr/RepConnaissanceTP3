:- dynamic partieGagnee/2, leCoupEstValideT/3, coordonneesOuListe/3, coupJoueDansGrille/5.
bonCoup(10).
mauvaisCoup(-10).

minmaxT(Grille, [A |ListeCoupsNew], Camp, GrilleArr):- 
    calculCoupT(Grille, A, 0, Pt, Camp,Camp).
    

%IA gagne
calculCoupT(Grille, [Lettre | Num], PointDeb, PointRet, CampA, CampCopaing) :-
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr), partieGagnee(CampA, GrilleArr),
    CampA == CampCopaing,
    PointRet is PointDeb + bonCoup.
%Joueur gagne
calculCoupT(Grille, [Lettre | Num], PointDeb, PointRet, CampA, CampCopaing) :-
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr), partieGagnee(CampA, GrilleArr),
    CampA \= CampCopaing,
    PointRet is PointDeb + mauvaisCoup.
calculCoupT(Grille, [Lettre | Num], PointDeb, PointRet, CampA, CampCopaing) :-
    joueLeCoupMinMaxT([Lettre,Num], CampA, Grille, GrilleArr), partieGagnee(CampA, GrilleArr),
    CampA == CampCopaing,
    PointRet is PointDeb + bonCoup.

joueLeCoupMinMaxT(Case, ValebonCoupur, GrilleDep, GrilleArr) :-
	coordonneesOuListe(Col, Lig, Case),
	leCoupEstValideT(Col, Lig, GrilleDep),
	coupJoueDansGrille(Col, Lig, Valeur, GrilleDep, GrilleArr).