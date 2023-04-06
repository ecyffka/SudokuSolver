:- use_module(library(clpfd)). 
:- use_module(library(statistics)).

:- [betterSolver].
:- [generator].

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
      write('2. Generate a sudoku'), nl,
      write('3. Find the difficulty of a sudoku'), nl,
      write('Choose from the following options or type "stop.": '),
      read(Input),
      process(Input).

process(stop) :-
      write('See you!'),
      !.

process(1) :-
      write('Provide a sudoku puzzle here: '),
      read(Sudoku),
      complete(Sudoku),
      write('***Display the solved sudoku***'),
      main_menu.

process(2) :-
      write('Choose a difficulty - easy, medium, difficult, evil: '),
      read(Difficulty),
      generate(Puzzle, Difficulty),
      displayBoard(Puzzle),
      main_menu.

process(3) :-
      write('Provide a sudoku puzzle here: '),
      read(Sudoku),
      difficulty(Sudoku, Difficulty),
      write('The difficulty of the sudoku puzzle is '), write(Difficulty),
      main_menu.

process(Input) :-
      write('Chosen option is '), write(Input), nl,
      write('Try again with a valid option: '),
      read(Input),
      process(Input).