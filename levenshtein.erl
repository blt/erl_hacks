-module(levenshtein).

-include_lib("eunit/include/eunit.hrl").
-export([distance/2]).

distance(A, <<>>) when is_binary(A) ->
    byte_size(A);
distance(<<>>, B) when is_binary(B) ->
    byte_size(B);
distance(A, B) when is_binary(A), is_binary(B) ->
    InitA = init(A),
    InitB = init(B),

    minimum(distance(InitA, B)     + 1,
            distance(A    , InitB) + 1,
            distance(InitA, InitB) + cost(A, B)).

%% ===================================================================
%%  Internal Functions
%% ===================================================================

init(<<>>) ->
    <<>>;
init(A) when is_binary(A) ->
    L = byte_size(A) - 1,
    <<Init:L/binary, _:1/binary>> = A,
    Init.

cost(A, B) when is_binary(A), is_binary(B) ->
    case binary:last(A) =:= binary:last(B) of
        true  -> 0;
        false -> 1
    end.

minimum(A, B, C) when A =< B, A =< C ->
    A;
minimum(A, B, C) when B =< A, B =< C ->
    B;
minimum(A, B, C) when C =< A, C =< B ->
    C.

%% ===================================================================
%%  Tests
%% ===================================================================

righteous_in_result_test_() ->
    [
     ?_assertMatch(3, distance(<<"kitten">>, <<"sitting">>)),
     ?_assertMatch(5, distance(<<"blue">>, <<"myself">>)),
     ?_assertMatch(3, distance(<<>>, <<"foo">>)),
     ?_assertMatch(0, distance(<<>>, <<>>)),
     ?_assertMatch(0, distance(<<"same">>, <<"same">>))
    ].
