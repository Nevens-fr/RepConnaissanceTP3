:- dynamic succAlphaT/2, succNumT/2.
% version recursive
%coupJoueDansLigne(b, b, [a,-,c], [a,-,c]).
%Ce prédicat modifie une ligne si celle-ci possède l'emplacement libre à la position donnée
coupJoueDansLigne(a, Val, [-|Reste],[Val|Reste]).
coupJoueDansLigne(NomCol, Val, [X|Reste1],[X|Reste2]):-
		succAlphaT(I,NomCol),
		coupJoueDansLigne(I, Val, Reste1, Reste2).


% Predicat : coupJoueDansGrille/5
%coupJoueDansGrille(a,2,x,[[-,-,x],[-,o,-],[x,o,o]],V).
%coupJoueDansGrille(a,2,x,[[-,-,x],[x,-,-],[x,o,o]],V).
% Insère un élement dans la grille si la position est libre
coupJoueDansGrille(NCol,1,Val,[A|Reste],[B|Reste]):- coupJoueDansLigne(NCol, Val, A, B).
coupJoueDansGrille(NCol, NLig, Val, [X|Reste1], [X|Reste2]):- succNumT(I, NLig),
					coupJoueDansGrille(NCol, I, Val, Reste1, Reste2).


% Predicat : ligneExiste/3
% ?- ligneExiste(x,[[x,-,x],[x,x,x],[-,o,-]],V).
% V = 2 ;
%Vérifie si une ligne est complète dans la grille
ligneExiste(Val, [L1|_], 1) :- ligneFaite(Val, L1).
ligneExiste(Val, [_|R], NumLigne) :- succNumT(I,NumLigne), ligneExiste(Val, R, I).


% Predicat : colonneExiste/3
%colonneExiste(x,[[x,-,x],[x,x,x],[-,o,-]],V).
%colonneExiste(x,[[x,-,x],[x,x,x],[x,o,-]],V).
%Ce prédicat vérifie si une colonne est complète
colonneExiste(Val, [[Val|_],[Val|_],[Val|_]], a).
colonneExiste(Val, [[_|R1],[_|R2],[_|R3]], NomCol) :-
	succAlphaT(I,NomCol),
	colonneExiste(Val, [R1,R2,R3], I).


% Predicats diagonaleDG/2 et diagonaleGD/2
%diagonaleGD(x,[[x,-,x],[x,x,x],[x,o,x]]).
%Vérifie si une diagonale est complète
diagonaleGD(Val, [[Val,_,_],[_,Val,_],[_,_,Val]]).
diagonaleDG(Val, [[_,_,Val],[_,Val,_],[Val,_,_]]).


% Predicat partieGagnee/2
%partieGagnee(x, [[-,x,-], [-,x,-], [x,x,-]]).
% regarde si un joueur donné à fini une ligne/colonne/diagonale
partieGagnee(Val, G) :- ligneExiste(Val, G, _).
partieGagnee(Val, G) :- colonneExiste(Val, G, _).
partieGagnee(Val, G) :- diagonaleGD(Val, G).
partieGagnee(Val, G) :- diagonaleDG(Val, G).

% ligneFaite(-,[-,-,-]).
% Vérifie si une ligne est remplie
ligneFaite(Val, [Val]).
ligneFaite(Val, [Val|R]) :- ligneFaite(Val, R).