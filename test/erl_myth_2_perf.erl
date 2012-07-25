-module(erl_myth_2_perf).
-compile(export_all).

-define(LIST_LEN, 10000).


list_comprehensions_perf() ->
    {setup,
        fun () -> list:seq(1, ?LIST_LEN) end,
        fun (_) -> ok end,
        [
            fun ?MODULE:list_comprehensions_are_slow/1
            %% @todo: compare this to something

        ]
    }.

list_comprehensions_are_slow(LongList) ->
    [{D, C}  || {C, D} <- [{A, B} || A <- LongList, B <- LongList]].
