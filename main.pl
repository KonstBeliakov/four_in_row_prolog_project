:- dynamic list_element_2d/3.
:- dynamic list_sizeX/1.
:- dynamic list_sizeY/1.
:- dynamic currentColor/1.

setColor(Color) :-
    retractall(currentColor(_)),
	assert(currentColor(Color)).

init(_) :-
    retractall(list_sizeX(_)),
    assert(list_sizeX(6)),

	retractall(list_sizeY(_)),
	assert(list_sizeY(7)),

	setColor(1),
    generate_list(_).

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

set_element(X, Y, Value) :-
    retractall(list_element_2d(X, Y, _)),
    assertz(list_element_2d(X, Y, Value)).

get_element(X, Y, Value) :-
    list_element_2d(X, Y, Value).

make_opponent_move(_).

move_element_down(X, Y) :-
    list_sizeX(SizeX),
    X < SizeX - 1,
    X1 is X + 1,
    get_element(X1, Y, 0),
    get_element(X, Y, Element),
    set_element(X1, Y, Element),
    set_element(X, Y, 0),
    move_element_down(X1, Y).

move_element_down(_, _).

make_move_helper(Y, Color) :-
    (get_element(0, Y, 0)->
    	write('Making move in column '), write(Y), write(':'), nl,
        set_element(0, Y, Color),
        move_element_down(0, Y),
        show_list(_),
        !
    ;   write('Can\'t make moves in column '), write(Y), write('.'), nl,
        !
    ).

make_move_helper(_, _).

make_move(Y) :-
    currentColor(Color),
    make_move_helper(Y, Color),
    currentColor(1) ->
        setColor(2);
        setColor(1).

% to test you can run:
% init(_),
% show_list(_),
% make_move(1),
% make_move(2),
% make_move(1).