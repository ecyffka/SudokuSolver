:- use_module(library(clpfd)). 
:- use_module(library(statistics)).

% PUZZLE GENERATOR FUNCTIONS %

/*
Generate a sudoku puzzle of the given difficulty
See the difficulty function for more details about difficulty ranking

generate(MinD,MaxD,Puzzle) is true when Puzzle is a sudoku puzzle
whose difficulty ranking lies within [MinD,MaxD].
Accepts a range of difficulties from 20 to 200. Generating puzzles
with difficulty over ~70 may take a long time or fail.
*/
generate(Puzzle,easy) :- generate(25,35,Puzzle).
generate(Puzzle,medium) :- generate(35,45,Puzzle).
generate(Puzzle,difficult) :- generate(45,55,Puzzle).
generate(Puzzle,evil) :- generate(55,100,Puzzle).
generate(MinD,MaxD,Puzzle) :- 
    MinD < MaxD,
    MinD >= 20,
    MaxD =< 200,
    generateSolvedBoard(S), 
    generateTemplate(S,MinD,MaxD,Puzzle), 
    displayBoard(Puzzle).

/*
Generates a random solved sudoku board (with no blanks).
*/
generateSolvedBoard(S) :- 
    sudoku(S), 
    maplist(randomLabel,S).

/*
Helper for generateSolvedBoard, generates a random labelling for the list
of constrained variables L.
See CLP(FD) for more details on labeling.
*/
randomLabel(L) :- random_between(0,100,Seed), labeling([random_value(Seed)],L).

/*
generateTemplate(S,MinD,MaxD,Template) is true when Template is a sudoku puzzle
that solves to the completed board S, and has a difficulty ranking within the
range [MinD,MaxD]
*/

generateTemplate(S,MinD,MaxD,Template) :- 
    randomCells(Blanks), 
    generateTemplate(MinD,MaxD,S,Blanks,Template,0).

generateTemplate(MinD,MaxD,T,_,T,Failures) :- 
    % generation is complete if this is true
    countSolutions(T,1), 
    difficulty(T,D), D >= MinD, D =< MaxD.

generateTemplate(MinD,MaxD,T,[[BlankI,BlankJ]|Blanks],Template,Failures) :- 
    % replace a cell in the template with the next random blank cell
    matrix_replace(T,BlankI,BlankJ,_,T2),
    countSolutions(T2,1),                           % ensure there is still only one solution
    numGround(T2,G), G > 17,                        % minimum number of clues for a board is 17
    generateTemplate(MinD,MaxD,T2,Blanks,Template,Failures). 
    
generateTemplate(MinD,MaxD,T,[_|Blanks],Template,Failures) :- 
    % skip adding the next blank to the board
    Failures < 50,
    Failures2 is Failures + 1,
    generateTemplate(MinD,MaxD,T,Blanks,Template,Failures2).

generateTemplate(MinD,MaxD,_,_,Template,Failures) :- 
    % number of failures is too high, try regenerating board
    Failures > 50,
    generateSolvedBoard(S), 
    randomCells(Blanks),
    generateTemplate(MinD,MaxD,S,Blanks,Template,0).


% BOARD SOLVER FUNCTION %

/*
Sudoku(Rows) returns true if Rows is a 9x9 2D matrix
that satisfies the constraints of a sudoku puzzle.

Different version of solver from betterSolver.pl,
more suited to estimating difficulty.

This version of solver was modified from
https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku
*/    
sudoku(Rows) :-
    length(Rows, 9),
    maplist(check, Rows),
    transpose(Rows, Columns),
    maplist(check, Columns),
    Rows = [A,B,C,D,E,F,G,H,I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I).

check(L) :- length(L, 9), L ins 1..9, all_distinct(L).

blocks([], [], []).
blocks([A1,A2,A3|T1], [B1,B2,B3|T2], [C1,C2,C3|T3]) :-
    check([A1,A2,A3,B1,B2,B3,C1,C2,C3]),
    blocks(T1, T2, T3).



% PUZZLE METRICS %

/*
Calculate the difficulty score of a puzzle.
difficulty(Rows,D) is true when D is the difficulty score for
the sudoku puzzle represented by Rows, the 2D array of the board.

Approximate score ranges are as follows:
Easy: 25-25
Medium: 35-45
Difficult: 45-55
Evil: 55+
*/
difficulty(Rows,D) :- 
    filledCorrectly(Rows,S,0,0), 
    call_time(sudoku(S), time{cpu:_,inferences:Inferences1,wall:_}), 
    call_time(maplist(label, S), time{cpu:_,inferences:Inferences2,wall:_}), 
    D2 is div(Inferences1,10000) + div(Inferences2,10000), 
    D is (D2).


/*
Count the number of possible solutions for a given puzzle.
countSolutions(Rows,Count) is true if the puzzle represented by Rows
has exactly Count solutions
*/
countSolutions(Rows,Count) :- 
    filledCorrectly(Rows,S,0,0), 
    sudoku(S), 
    length(L,Count), 
    findall(1,maplist(label, S),L).

/*
numGround(Rows,Count) is true when Count is the number of ground
variables in the 2D array Rows
*/
numGround(Rows,Count) :- findall(1,cellGround(Rows, _, _, _),L), length(L,Count).

/* 
filledCorrectly(T,F) is true when the filled or partially filled board F is a validly 
filled version of the template board T.

filledCorrectly(T,F,I,J) is the same, except only considers the submatrix from [I,J] to 
[8,8].
*/
filledCorrectly(F,T) :- filledCorrectly(F,T,0,0).
filledCorrectly(_,_,8,8).
filledCorrectly(T,F,I,J) :- I < 8, validCell(T,F,I,J), I2 is I + 1, filledCorrectly(T,F,I2,J).
filledCorrectly(T,F,I,J) :- I = 8, validCell(T,F,I,J), J2 is J + 1, filledCorrectly(T,F,0,J2).

/*
validCell(T,F,I,J) is true when the cell [I,J] in the filled board F is valid given the
template board T.
A cell is valid if the template board contains a blank, or the template board and filled
board both contain the same ground number.
*/
validCell(T,F,I,J) :- cellGround(T, I, J, X), cellGround(F, I, J, X).
validCell(T,_,I,J) :- matrix(T, I, J, X), \+number(X). 

% MATRIX HELPER FUNCTIONS %

/* 
matrix(Matrix, I, J, Value) is true when Value is the value of
the cell [I,J] in Matrix.
*/
matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

/*
list_replace(L, I, Value, New) is true when New is the list
with all the same entries as L, except the entry at the I'th
index contains the value Value.
*/
list_replace(L, I, Value, New) :-
    nth0(I,L,_,T),
    nth0(I,New,Value,T).

/*
matrix_replace(M, I, J, Old, Value, New) is true when New is the matries
with all the same entries as M, except the cell [I,J] is replaced with 
the value Value.
*/
matrix_replace(M,I,J,Value,New) :-
    nth0(I, M, OldRow),
    list_replace(OldRow, J, Value, NewRow),
    list_replace(M, I, NewRow, New).

/*
cellGround(M, I, J, X) is true when cell [I,J] contains the ground number X in M
*/
cellGround(M, I, J, X) :- matrix(M, I, J, X), number(X).

/*
Generate a random permutation of all the cells in a 9x9 2D array
*/
randomCells(Result) :- 
    findall([I,J],(between(0,8,I), between(0,8,J)), Blank), 
    random_permutation(Blank,Result).

/*
Displays a 2D array representing a sudoku board
*/
displayBoard(Rows) :- maplist(portray_clause, Rows).