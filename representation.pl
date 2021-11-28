:- dynamic grilleDeDepart/1.
% Predicat : succNumT/2 ou succNumO/2
% Le prédicat sert à afficher le nombre suivant le nombre donné ou à valider une suite de nombre pour le Tic Tac Toe
succNumT(1,2).
succNumT(2,3).

succNumO(1,2).
succNumO(2,3).
succNumO(3,4).
succNumO(4,5).
succNumO(5,6).
succNumO(6,7).
succNumO(7,8).

succNumS(8,9).

% Predicat : succAlphaT/2 ou succAlphaO/2
% Le prédicat sert à afficher la lettre suivante la lettre donnée ou à valider une suite de lettre pour le Tic Tac Toe
succAlphaT(a,b).
succAlphaT(b,c).

succAlphaO(a,b).
succAlphaO(b,c).
succAlphaO(c,d).
succAlphaO(d,e).
succAlphaO(e,f).
succAlphaO(f,g).
succAlphaO(g,h).

succAlphaS(h,i).

% Predicat : afficheLigne/1
% Le prédicat sert à afficher une ligne quelque soit le nombre d'éléments
afficheLigne([]):- write('|').
afficheLigne([A | AS]) :- write('|'), tab(1), write(A), tab(1), afficheLigne(AS).

% Predicat : afficheGrille/1
% Le prédicat permet d'afficher une grille générique
afficheGrille(A) :- tab(1),affLettres(A, a), nl, afficheGrille2(A, 1).

%%%%%%%
% Predicat : afficheGrille/2
afficheGrille2([], _).
afficheGrille2([A | AS], B) :- affNum(B, C),afficheLigne(A), nl,afficheGrille2(AS, C).

%%%%%%%
% Predicat : affLettres/2
%Affiche les lettres au dessus de la grille
affLettres([], _).
affLettres([_|AS], A):- tab(3), write(A), succAlphaO(A,B), affLettres(AS,B).
affLettres([_|AS], A):- succAlphaS(A,B), affLettres(AS,B).

%%%%%%%
% Predicat : affNum/2
%Affiche les numéros de ligne
affNum(A, B) :- write(A), tab(1), succNumO(A,B).
affNum(A, B) :- succNumS(A,B).

%OTHELLO
%%% Permet d afficher la grille au demarrage du jeu
% Predicat : afficheGrilleDep/0
% Usage : afficheGrilleDep affiche la grille de depart du jeu d othello,
%         sous la forme d une grille

afficheGrilleDep:-
	grilleDeDepart(G),
	afficheGrille(G),!.