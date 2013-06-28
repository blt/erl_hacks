# erl_hacks

A repository of small hacks.

## levenshtein.erl

This file implements a naive
[levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance).
Eunit tests are included. Example use:

    > erl
    Erlang R15B03 (erts-5.9.3) [source] [64-bit] [smp:8:8] [async-threads:0]
    [hipe] [kernel-poll:false]

    Eshell V5.9.3  (abort with ^G)
    1> c("levenshtein.erl").
    {ok,levenshtein}
    2> levenshtein:test().
      All 5 tests passed.
    ok
