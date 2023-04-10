:- use_module(library(clpfd)).
:- [generator].

% easy: [5,2,A3,B1,B2,1,C1,C2,C3],[A4,A5,4,B4,2,B6,C4,C5,C6],[A7,A8,1,3,B8,B9,8,C8,C9],[7,D2,D3,E1,9,5,F1,6,3],[D4,D5,D6,E4,E5,E6,F4,F5,F6],[8,6,D9,7,1,E9,F7,F8,9],[G1,G2,8,H1,H2,9,2,I2,I3],[G4,G5,G6,H4,5,H6,3,I5,I6],[G7,G8,G9,6,H8,H9,I7,4,7]

% hintSquareUI: fills in the requested box in a given Sudoku puzzle
% input: the indexes of a single square in the grid followed by nine lists with nine numbers each, 
%         represents the nine rows of a sudoku grid from top to bottom
% output: true if input is a valid sudoku puzzle, provide partial soution where cell [I,J] is filled in
hintSquareUI(I,J, Rows) :- 
    nth1(I, Rows, Row),
    nth1(J, Row, Cell),
    hintSquare(Cell, Rows).

% hintSquare: fills in the requested box in a given Sudoku puzzle (plus any equivalent boxes..)
% input: a variable corresponding to a single square in the grid followed by nine lists with nine numbers each, 
%         represents the nine rows of a sudoku grid from top to bottom
% output: true if input is a valid sudoku puzzle, provide partial soution
hintSquare(X, Rows) :- 
    checkAll(Rows),
    label([X]),
    maplist(portray_clause, Rows).  

% hintRow: fills in the requested row [1-9] in a given Sudoku puzzle (plus any equivalent boxes..)
% input: a row number [1-9] followed by nine lists with nine numbers each, represents the nine rows of a sudoku grid from top to bottom
% output: true if input is a valid sudoku puzzle, provide partial soution
hintRow(I, Rows) :- 
    checkAll(Rows),
    nth1(I, Rows, Row),
    label(Row),
    maplist(portray_clause, Rows).  

checkAll([]).
checkAll([Row1|Rows]) :- 
    check(Row1),
    checkAll(Rows).

% check(L) :- L ins 1..9, all_different(L).
