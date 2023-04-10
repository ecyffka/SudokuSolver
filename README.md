# SudokuSolver

# What is the problem?
### We want to see if logical programming is suitable for combinatorial problems-- specifically a Sudoku solver. We were advised that Prolog executes search in a brute force fashion, so we'll be paying attention to inefficiencies and potential optimizations. 

# What is the something extra?
### A "hint" feature that will partially solve a given Sudoku puzzle, and a Sudoku generator that will generate solvable puzzles of varying difficulties. Thus we will also need to generate a metric for “difficulty” of a puzzle.

# What did we learn from doing this?
### Logical programming is suitable for combinatorial problems, however, there must be some way to restrict the problem domain. Taking a naive approach to a Sudoku solver (ie. just check that all rows/columns/squares contain the number 1-9) does not work for anything beyond the most simple of puzzles with only a small number of unfilled boxes. As warned by the TA prior to beginning our project, this is likely due to the combination of unrestricted domain and the way Prolog executes search.

### The Constraint Logic Programming Over Finite Domains (clpfd) library (https://www.swi-prolog.org/man/clpfd.html), however, makes the problem much more manageable, allowing us to put constraints on possible values and drastically reducing the number of combinations that the program needs to check. With this improvement, puzzles labelled as “Expert” on online Sudoku sites can be completed near-instantly. 

### Logic programming was also suitable for the task of generating a Sudoku puzzle within a certain difficulty range. Again using the clpfd library to place constraints, we were able to generate a random valid Sudoku board, and then add blank cells to achieve a puzzle within a difficulty range using our own difficulty metric. Potentially, the puzzle generation algorithm could be made “smarter” and more efficient using more clpfd constraints instead of randomly adding blanks to the puzzle.
