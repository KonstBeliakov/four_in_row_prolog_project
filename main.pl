:- dynamic list_element_2d/3.
:- dynamic list_sizeX/1.
:- dynamic list_sizeY/1.

init(_) :-
    retractall(list_sizeX(_)),
    assert(list_sizeX(6)),

	retractall(list_sizeY(_)),
	assert(list_sizeY(7)).

generate_list_row_helper(RowNumber, Y) :-
    list_sizeY(SizeY),
    Y < SizeY,
    assertz(list_element_2d(RowNumber, Y, 0)),
    Y1 is Y + 1,
    generate_list_row_helper(RowNumber, Y1).

generate_list_row_helper(_, Y) :-   % когда X >= SizeX, ничего не делаем.
    list_sizeY(SizeY),
    Y >= SizeY.

generate_list_row(RowNumber) :- generate_list_row_helper(RowNumber, 0).

generate_list_helper(X) :-
    list_sizeX(SizeX),
    X < SizeX,
    generate_list_row(X),
    X1 is X + 1,
    generate_list_helper(X1).

generate_list_helper(X) :-
    list_sizeX(SizeX),
    X >= SizeX.

generate_list(_) :- generate_list_helper(0).

show_list_row_helper(X, Y) :-
    list_sizeY(SizeY),
    (Y < SizeY ->
    	list_element_2d(X, Y, Element),
    	write(Element), write(' '),
    	Y1 is Y + 1,
    	show_list_row_helper(X, Y1);

    	nl
    ).

show_list_row_helper(Y) :-   % когда X >= SizeX, ничего не делаем
    list_sizeY(SizeY),
    Y >= SizeY,
    nl.

show_list_row(X) :- show_list_row_helper(X, 0).

show_list_helper(X) :-
    list_sizeX(SizeX),
    X < SizeX,
    (show_list_row(X); write('\n')),
    write('\n'),
    X1 is X + 1,
    show_list_helper(X1).

show_list_helper(X) :-
    list_sizeX(SizeX),
    X >= SizeX.

show_list(_) :- show_list_helper(0).

% for testing:
% (
%   init(_),
%   generate_list(_),
%   show_list(_)
% ).
