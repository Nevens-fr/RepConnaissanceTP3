:- dynamic lanceJeu/0.
%%%%%%%
% Predicat : loadTicTacToe/0
% Charge tous les fichiers relatif au tic tac toe et exécute le jeu
loadTicTacToe:-
    consult(tictactoe),
    consult(evaluation),
    consult(minmax),
    consult(regle),
    consult(representation),
    lanceJeu.

%%%%%%%
% Predicat : loadOthello/0
% Charge tous les fichiers relatif au tic tac toe et exécute le jeu
loadOthello:-
    consult(othello),
    consult(representation),
    consult(regle),
    consult(evaluation),
    lanceJeu.

%%%%%%%
% Predicat : menuPrincipal/0
% Demande au joueur de séléctionner le jeu
% Et appelle la fonction nécessaire au lancement
menuPrincipal:-
    writeln("Selectionnez le jeu à lancer :"), nl,
    writeln("1 - TicTacToe"), nl,
    writeln("2 - Othello"), nl,
    read(NumeroJeu),
    writeln("Lancement du jeu en cours..."), nl,
    lancementJeu(NumeroJeu).

%%%%%%%
% Predicat : lancementJeu/1
% Predicat intermediaire permettant d'appeler la fonction
% De lancement de jeu
lancementJeu(1):- loadTicTacToe.
lancementJeu(2):- loadOthello.