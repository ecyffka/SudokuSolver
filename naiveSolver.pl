% [4,5,3,7,8,1,2,6,9],[6,1,7,5,9,2,8,4,3],[8,9,2,6,4,3,7,5,1],[9,8,4,2,3,6,1,7,5],[1,7,6,9,5,8,3,2,4],[2,3,5,4,1,7,6,9,8],[3,6,9,8,7,5,4,1,2],[7,4,8,1,2,9,5,3,6],[5,2,1,3,6,4,9,8,7]
% [4,5,3,7,8,1,2,6,9],[6,1,7,5,9,2,8,4,3],[8,9,2,6,4,3,7,5,1],[9,8,4,2,3,6,1,7,5],[1,7,6,9,5,8,3,2,4],[2,3,5,4,1,7,6,9,8],[3,6,9,8,7,5,4,1,2],[7,4,8,1,2,9,5,3,6],[5,2,1,3,6,4,9,Eight,7]

% input: nine lists with nine numbers each, represents the nine rows of a sudoku grid from top to bottom
% output: true if input is a completed sudoku puzzle (or provides solution to an incomplete puzzle)
complete([A1,A2,A3,B1,B2,B3,C1,C2,C3],
    [A4,A5,A6,B4,B5,B6,C4,C5,C6],
    [A7,A8,A9,B7,B8,B9,C7,C8,C9],
    [D1,D2,D3,E1,E2,E3,F1,F2,F3],
    [D4,D5,D6,E4,E5,E6,F4,F5,F6],
    [D7,D8,D9,E7,E8,E9,F7,F8,F9],
    [G1,G2,G3,H1,H2,H3,I1,I2,I3],
    [G4,G5,G6,H4,H5,H6,I4,I5,I6],
    [G7,G8,G9,H7,H8,H9,I7,I8,I9]) :- 
    check([A1,A2,A3,B1,B2,B3,C1,C2,C3]),
    check([A4,A5,A6,B4,B5,B6,C4,C5,C6]),
    check([A7,A8,A9,B7,B8,B9,C7,C8,C9]),
    check([D1,D2,D3,E1,E2,E3,F1,F2,F3]),
    check([D4,D5,D6,E4,E5,E6,F4,F5,F6]),
    check([D7,D8,D9,E7,E8,E9,F7,F8,F9]),
    check([G1,G2,G3,H1,H2,H3,I1,I2,I3]),
    check([G4,G5,G6,H4,H5,H6,I4,I5,I6]),
    check([G7,G8,G9,H7,H8,H9,I7,I8,I9]),
    check([A1,A2,A3,A4,A5,A6,A7,A8,A9]),
    check([B1,B2,B3,B4,B5,B6,B7,B8,B9]),
    check([C1,C2,C3,C4,C5,C6,C7,C8,C9]),
    check([D1,D2,D3,D4,D5,D6,D7,D8,D9]),
    check([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
    check([F1,F2,F3,F4,F5,F6,F7,F8,F9]),
    check([G1,G2,G3,G4,G5,G6,G7,G8,G9]),
    check([H1,H2,H3,H4,H5,H6,H7,H8,H9]),
    check([I1,I2,I3,I4,I5,I6,I7,I8,I9]),
    check([A1,A4,A7,D1,D4,D7,G1,G4,G7]),
    check([A2,A5,A8,D2,D5,D8,G2,G5,G8]),
    check([A3,A6,A9,D3,D6,D9,G3,G6,G9]),
    check([B1,B4,B7,E1,E4,E7,H1,H4,H7]),
    check([B2,B5,B8,E2,E5,E8,H2,H5,H8]),
    check([B3,B6,B9,E3,E6,E9,H3,H6,H9]),
    check([C1,C4,C7,F1,F4,F7,I1,I4,I7]),
    check([C2,C5,C8,F2,F5,F8,I2,I5,I8]),
    check([C3,C6,C9,F3,F6,F9,I3,I6,I9]).

check(L) :- member(1,L), member(2,L), member(3,L), member(4,L), member(5,L), 
    member(6,L), member(7,L), member(8,L), member(9,L).