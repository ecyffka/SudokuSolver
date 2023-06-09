% Puzzles from https://www.sudokuoftheday.com/dailypuzzles

none(P) :- P = [
    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_],

    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_],

    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_],
    [_,_,_, _,_,_, _,_,_]].

beginner(P) :- P = [ % 21
    [_,_,7, _,_,9, _,4,_],
    [2,_,_, 5,7,_, _,_,_],
    [3,8,_, _,2,_, _,7,_],

    [1,_,3, 2,4,7, _,_,6],
    [_,6,_, 8,_,3, _,9,_],
    [8,_,_, 9,6,5, 7,_,3],
    
    [_,3,_, _,9,_, _,2,8],
    [_,_,_, _,8,6, _,_,1],
    [_,1,_, 4,_,_, 6,_,_]].

easy(P) :- P = [ % 31
    [_,_,8, _,_,5, 3,_,_],
    [2,_,_, 6,_,_, 9,4,_],
    [_,3,4, _,_,_, 2,_,_],

    [_,4,_, _,9,1, _,_,8],
    [5,_,_, _,6,_, _,_,2],
    [9,_,_, _,8,_, _,5,_],
    
    [_,_,5, _,_,_, 4,7,_],
    [_,6,9, _,_,7, _,_,3],
    [_,_,1, 9,_,_, 5,_,_]].

medium(P) :- P = [ % 38
    [_,_,5, _,_,1, _,_,8],
    [_,_,7, 9,3,2, _,_,_],
    [_,_,_, _,_,_, _,3,_],

    [_,_,9, _,6,_, 4,_,_],
    [1,_,_, 7,_,3, _,_,2],
    [_,_,3, _,9,_, 7,_,_],

    [_,4,_, _,_,_, _,_,_],
    [_,_,_, 8,5,4, 3,_,_],
    [9,_,_, 3,_,_, 8,_,_]].

difficult(P) :- P = [ % 44
    [5,3,_, _,_,9, _,2,_],
    [_,_,_, 8,_,2, _,_,1],
    [_,_,4, _,7,_, _,5,_],

    [_,_,_, _,_,3, _,7,4],
    [_,_,5, _,8,_, 9,_,_],
    [3,7,_, 1,_,_, _,_,_],

    [_,1,_, _,3,_, 2,_,_],
    [4,_,_, 9,_,6, _,_,_],
    [_,5,_, 7,_,_, _,9,6]].

evil(P) :- P = [ % 91
    [_,_,_, 6,_,_, 4,_,_],
    [7,_,_, _,_,3, 6,_,_],
    [_,_,_, _,9,1, _,8,_],
    [_,_,_, _,_,_, _,_,_],
    [_,5,_, 1,8,_, _,_,3],
    [_,_,_, 3,_,6, _,4,5],
    [_,4,_, 2,_,_, _,6,_],
    [9,_,3, _,_,_, _,_,_],
    [_,2,_, _,_,_, 1,_,_]].

platinumBlonde(P) :- P = [  % 1943
    [_,_,_,_,_,_,_,1,2],
    [_,_,_,_,_,_,_,_,3],
    [_,_,2,3,_,_,4,_,_],
    [_,_,1,8,_,_,_,_,5],
    [_,6,_,_,7,_,8,_,_],
    [_,_,_,_,_,9,_,_,_],
    [_,_,8,5,_,_,_,_,_],
    [9,_,_,_,4,_,5,_,_],
    [4,7,_,_,_,6,_,_,_]].

% Get the 2D array of the sudoku board according to the user input
% The first argument is the name of the board, and P is the 2D array
getPuzzle(none, P) :-
      none(P).
getPuzzle(beginner, P) :-
      beginner(P).
getPuzzle(easy, P) :-
      easy(P).
getPuzzle(medium, P) :-
      medium(P).
getPuzzle(difficult, P) :-
      difficult(P).
getPuzzle(evil, P) :-
      evil(P).
getPuzzle(platinumBlonde, P) :-
      platinumBlonde(P).