:- dynamic(list_element_2d/3).
:- dynamic(list_sizeX/1).
:- dynamic(list_sizeY/1).

generate_list_row_helper(RowNumber, Y) :-
    list_sizeY(SizeY),
    Y < SizeY,
    assertz(list_element_2d(RowNumber, Y, 0)),
    Y1 is Y + 1,
    generate_list_row_helper(RowNumber, Y1).

generate_list_row_helper(_, Y) :-
    list_sizeY(SizeY),
    Y >= SizeY.

generate_list_row(RowNumber) :-
    generate_list_row_helper(RowNumber, 0).

generate_list_helper(X) :-
    list_sizeX(SizeX),
    X < SizeX,
    generate_list_row(X),
    X1 is X + 1,
    generate_list_helper(X1).

generate_list_helper(X) :-
    list_sizeX(SizeX),
    X >= SizeX.

generate_list :-
    generate_list_helper(0);
    true.

show_list_row_helper(X, Y) :-
    list_sizeY(SizeY),
    Y < SizeY,
    list_element_2d(X, Y, Element),
    (Element =:= 0 ->
        write(' ')
    ;
        write(Element)
    ),
    write('|'),
    Y1 is Y + 1,
    show_list_row_helper(X, Y1).

show_list_row_helper(Y) :-
    list_sizeY(SizeY),
    Y >= SizeY.

show_list_row(X) :-
    write('|'),
    (show_list_row_helper(X, 0); true),
    nl.

show_list_helper(X) :-
    list_sizeX(SizeX),
    X < SizeX,
    show_list_row(X),
    write_line('-'),
    X1 is X + 1,
    show_list_helper(X1).

show_list_helper(X) :-
    list_sizeX(SizeX),
    X >= SizeX.

write_line_helper(_, 0) :-
    nl.
write_line_helper(Char, N):-
    write(Char),
    N1 is N - 1,
    write_line_helper(Char, N1).

write_line(Char) :-
    list_sizeY(SizeY),
    Size1 is SizeY * 2 + 1,
    write_line_helper(Char, Size1).

show_list :-
    write_line('-'),
    show_list_helper(0).

set_element(X, Y, Value) :-
    retractall(list_element_2d(X, Y, _)),
    assertz(list_element_2d(X, Y, Value)).

get_element(X, Y, Value) :-
    list_element_2d(X, Y, Value).



check_horizontal_win :-
    list_sizeX(SX),
    list_sizeY(SY),
    EndX is SX - 1,
    EndY is SY - 3,
    between(0, EndX, X),
    between(0, EndY, Y),
    get_element(X, Y, P),
    Y1 is Y + 1,
    Y2 is Y + 2,
    Y3 is Y + 3,
    get_element(X, Y1, P),
    get_element(X, Y2, P),
    get_element(X, Y3, P),
    P \= 0.

check_vertical_win :-
    list_sizeX(SX),
    list_sizeY(SY),
    EndX is SX - 3,
    EndY is SY - 1,
    between(0, EndX, X),
    between(0, EndY, Y),
    get_element(X, Y, P),
    X1 is X + 1,
    X2 is X + 2,
    X3 is X + 3,
    get_element(X1, Y, P),
    get_element(X2, Y, P),
    get_element(X3, Y, P),
    P \= 0.

check_diagonal_win :-
    list_sizeX(SX),
    list_sizeY(SY),
    EndX is SX - 3,
    EndY is SY - 3,
    between(0, EndX, X),
    between(0, EndY, Y),
    get_element(X, Y, P),
    X1 is X + 1,
    X2 is X + 2,
    X3 is X + 3,

    Y1 is Y + 1,
    Y2 is Y + 2,
    Y3 is Y + 3,
    get_element(X1, Y1, P),
    get_element(X2, Y2, P),
    get_element(X3, Y3, P),
    P \= 0.

check_wins :-
    check_horizontal_win;
    check_vertical_win;
    check_diagonal_win.

are_empty_cells :-
    get_element(0, Y, E),
    E =:= 0.

