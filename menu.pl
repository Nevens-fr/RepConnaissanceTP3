
%%%%%%%
% Predicat : loadTicTacToe/0
% Charge tous les fichiers relatif au tic tac toe et demande au joueur de choisir le mode de jeu
loadTicTacToe:-
    consult(tictactoe),
    consult(evaluation),
    consult(minmax),
    consult(regle),
    consult(representation),
    writeln("Sélectionnez le mode de jeu : "), nl,
    writeln("1 - Joueur VS IA"), nl,
    writeln("2 - Joueur VS Joueur"), nl,
    read(NumeroMode),
    lancementMode(NumeroMode).


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

%%%%%%%
% Predicat : lancementMode/1
% Predicat permettant de lancer le bon mode de jeu du Tic Tac Toe
lancementMode(1):- lanceJeu.
lancementMode(2):- lanceJeuJcJ.