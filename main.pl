:- use_module(library(clpfd)). 
:- use_module(library(statistics)).

:- [betterSolver].
:- [generator].
:- [testPuzzles].
:- [hint].

% UI of the sudoku solver & generator application %

% ?- [main].

% TODO
% 1. and 3. How to get user input of sudoku puzzle. CSV like https://github.com/declanherbertson/sudoku, or directly read in 2D array?
% 3. Check if the difficulty calculator works after the puzzle read is complete
% 2. Improve the appearance of the generated puzzle. At least separate consecutive puzzles

% reference https://www.tutorialspoint.com/prolog/prolog_inputs_and_outputs.htm
% To start the program, ?- main_menu.
main_menu :-
      nl,
      write('1. Solve sudoku with the application'), nl,
      write('2. Get a hint for a sudpku puzzle'), nl,
      write('3. Generate a sudoku'), nl,
      write('4. Find the difficulty of a sudoku'), nl,
      write('Choose from the options above or type "stop.": '),
      read(Input),
      process(Input).

process(stop) :-
      write('See you!'),
      !.

process(1) :-
      write('Provide a sudoku puzzle here: '),
      % read(Sudoku),
      % complete(Sudoku),
      % read_sudoku(List1, List2, List3, List4, list5, List6, List7, List8, List9),
      % complete(List1, List2, List3, List4, list5, List6, List7, List8, List9),
      read(Sudoku),
      solve_puzzle(Sudoku),
      main_menu.

solve_puzzle(Sudoku) :-
      get_puzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('Solved Puzzle'), nl,
      complete(P).

get_puzzle(none, P) :-
      none(P).
get_puzzle(beginner, P) :-
      beginner(P).
get_puzzle(easy, P) :-
      easy(P).
get_puzzle(medium, P) :-
      medium(P).
get_puzzle(difficult, P) :-
      difficult(P).
get_puzzle(evil, P) :-
      evil(P).
get_puzzle(platinumBlonde, P) :-
      platinumBlonde(P).

/*
sub_menu(Sudoku) :-
      write('1. Solve the sudoku'), nl,
      write('2. Get a hint'), nl,
      write('Choose from the options: '),
      read(Input),
      process_solve_hint(Input, Sudoku).
*/

process(2) :-
      write('Provide a sudoku puzzle here: '),
      read(Sudoku),
      write('Hint type 1: A row, Hint type 2: A square: '),
      read(HintType),
      give_hint(HintType, Sudoku),
      % write('Which row do you want a hint for?: '),
      % read(RowNo),
      % hint_puzzle(Sudoku, RowNo),
      main_menu.

give_hint(1, Sudoku) :-
      write('Which row do you want a hint for?: '),
      read(RowNo),
      get_puzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('The Puzzle with the Hint on the Row '), write(RowNo), nl,
      hintRow(RowNo, P).

give_hint(2, Sudoku) :-
      write('Which square do you want a hint for?: '),
      read(SquareNo),
      get_puzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('The Puzzle with the Hint on the Square '), write(SquareNo), nl,
      hintSquare(SquareNo, P).

hint_puzzle(Sudoku, RowNo) :-
      get_puzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('The Puzzle with the Hint on the Row '), write(RowNo), nl,
      hintRow(RowNo, P).

process(3) :-
      write('Choose a difficulty - easy, medium, difficult, evil: '),
      read(Difficulty),
      generate(Puzzle, Difficulty),
      displayBoard(Puzzle),
      main_menu.

process(4) :-
      write('Provide a sudoku puzzle here: '),
      read(Sudoku),
      get_puzzle(Sudoku, P),
      difficulty(P, Difficulty),
      write('The difficulty of the sudoku puzzle is '), write(Difficulty),
      main_menu.

process(Input) :-
      write('Chosen option is '), write(Input), nl,
      write('Try again with a valid option.'),
      main_menu.

% Read a sudoku puzzle which is a list of 9 lists of numbers
read_sudoku(A, B, C, D, E, F, G, H, I) :-
      read(A),
      read(B),
      read(C),
      read(D),
      read(E),
      read(F),
      read(G),
      read(H),
      read(I).

read_mul(A, B) :-
      read(A),
      read(B).