:- [betterSolver].
:- [generator].
:- [testPuzzles].
:- [hint].

:- discontiguous process/1.

% UI of the sudoku solver & generator application %

% ?- [main].

% reference https://www.tutorialspoint.com/prolog/prolog_inputs_and_outputs.htm
% To start the program, ?- main.
% Shows the options for the user and get user input of the option
main :-
      nl,
      write('---Main Menu---'), nl,
      write('1. Solve sudoku with the application'), nl,
      write('2. Get a hint for a sudoku puzzle'), nl,
      write('3. Generate a sudoku'), nl,
      write('4. Find the difficulty of a sudoku'), nl,
      write('Choose from the options above or type "stop.": '),
      read(Input),
      process(Input).

% Print a message while terminating the program.
process(stop) :-
      write('See you!'),
      !.

% Process the option 1 - solve a sudoku puzzle, and goes back to the main menu
process(1) :-
      write('Provide a sudoku puzzle here'),
      read(Sudoku),
      solvePuzzle(Sudoku),
      main.

% Helper function of process(1)
% Get a puzzle, the 2D array of the board, and display the original and solved puzzle.
solvePuzzle(Sudoku) :-
      getPuzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('Solved Puzzle'), nl,
      complete(P).

% Process option 2 - Hint
% Gets user input for a sudoku puzzle and kind of hint they want, processes the hint, 
% and goes back to the main menu.
process(2) :-
      write('Hint type 1 - A row, Hint type 2 - A square'),
      read(HintType),
      write('Provide a sudoku puzzle here'),
      read(Sudoku),
      giveHint(HintType, Sudoku),
      main.

% Gives the hint for a row. Displays the original puzzle and the board with the hint.
giveHint(1, Sudoku) :-
      getPuzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('Which row do you want a hint for?: '),
      read(RowNo),
      write('The Puzzle with the Hint on the Row '), write(RowNo), nl,
      hintRow(RowNo, P).

% Gives the hint for a square. Displays the original puzzle and the board with the hint.
giveHint(2, Sudoku) :-
      getPuzzle(Sudoku, P),
      write('Original Puzzle'), nl,
      displayBoard(P),
      write('Which square do you want a hint for?'), nl,
      write('Row'), read(RowNo), write('Column'), read(ColNo),
      write('The Puzzle with the Hint on the Square '), write('['), write(RowNo), write(', '), write(ColNo), write(']'), nl,
      hintSquareUI(RowNo, ColNo, P).

% Processes option 3 - generate a puzzle with a given difficulty
% Gets a user input for the difficulty, generate a puzzle and displays it.
% Goes back to the main menu.
process(3) :-
      write('Choose a difficulty - easy, medium, difficult, evil: '),
      read(Difficulty),
      generate(_, Difficulty),
      main.

% Processes option 4 - detect the difficulty of a sudoku puzzle.
% Gets the user input for a puzzle and display its difficulty score.
% Goes back to the main menu.
process(4) :-
      write('Provide a sudoku puzzle here'),
      read(Sudoku),
      getPuzzle(Sudoku, P),
      write('The Puzzle given'), nl,
      displayBoard(P),
      difficulty(P, Score),
      write('The difficulty of the sudoku puzzle is '), write(Score), nl,
      main.

% Handles an invalid input for the main menu options.
process(Input) :-
      write('Chosen option is '), write(Input), nl,
      write('Try again with a valid option.'),
      main.