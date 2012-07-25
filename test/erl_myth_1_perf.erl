-module(erl_myth_1_perf).
-compile(export_all).

-define(COLLATZ_SEQ_NUMS, lists:seq(1, 10000)).


funs_are_slow_perf() ->
    ForeachFun = fun
        (_Fun, [], _Self) ->
            ok;
        (Fun, [X|XS], Self) ->
            Fun(X),
            Self(Fun, XS, Self)
    end,
    CollatzFun = fun
        (1, _Self) ->
            1;
        (N, Self) when N rem 2 == 0 ->
            Self(N div 2, Self);
        (N, Self) ->
            Self(3*N + 1, Self)
    end,
    %% @doc this is not quite the same, I know, will think of how to fix.
    ForeachFun(
        fun (Num) -> CollatzFun(Num, CollatzFun) end,
        ?COLLATZ_SEQ_NUMS,
        ForeachFun).

not_funs_are_fast_perf() ->
    lists:foreach(fun collatz_number/1, ?COLLATZ_SEQ_NUMS).

collatz_number(1) ->
    1;
collatz_number(N) when ((N rem 2) == 0) ->
    collatz_number(N div 2);
collatz_number(N) ->
    collatz_number(3*N + 1).
