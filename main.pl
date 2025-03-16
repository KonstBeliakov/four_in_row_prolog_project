:- ensure_loaded('./board.pl').

:- dynamic(currentColor/1).

setColor(Color) :-
    retractall(currentColor(_)),
	assert(currentColor(Color)).

init :-
    retractall(list_sizeX(_)),
    assert(list_sizeX(6)),

	retractall(list_sizeY(_)),
	assert(list_sizeY(7)),

	setColor(1),
    generate_list.

make_opponent_move.

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
        format("Making move in column ~w:\n", [Y]),
        set_element(0, Y, Color),
        move_element_down(0, Y),
        show_list,
        !
    ;   format("Can't make moves in column ~w.", [Y]),
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