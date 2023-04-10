:- use_module(library(clpfd)). 
:- use_module(library(statistics)).

:- [betterSolver].
:- [generator].
:- [testPuzzles].

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
      write('2. Get a hint for a sudpku puzzle'),
      write('3. Generate a sudoku'), nl,
      write('4. Find the difficulty of a sudoku'), nl,
      write('Choose from the options above or type "stop.": '),
      read(Input),
      process(Input).

process(stop) :-
      write('See you!'),
      !.

process(1) :-
      write('option 1'), nl,
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
/*
sub_menu(Sudoku) :-
      write('1. Solve the sudoku'), nl,
      write('2. Get a hint'), nl,
      write('Choose from the options: '),
      read(Input),
      process_solve_hint(Input, Sudoku).
*/

process(2) :-
      write('option 2'), nl,
      write('Provide a sudoku puzzle here: '),
      read(Sudoku).


process(3) :-
      write('Choose a difficulty - easy, medium, difficult, evil: '),
      read(Difficulty),
      generate(Puzzle, Difficulty),
      displayBoard(Puzzle),
      main_menu.

process(4) :-
      write('Provide a sudoku puzzle here: '),
      % read(Sudoku),
      % difficulty(Sudoku, Difficulty),
      % read_sudoku(List1, List2, List3, List4, list5, List6, List7, List8, List9),
      % difficulty([List1, List2, List3, List4, list5, List6, List7, List8, List9], Difficulty),
      % write('The difficulty of the sudoku puzzle is '), write(Difficulty),
      write('option 3 chosen'),
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