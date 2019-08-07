module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (Msg(..), update)
import Test exposing (..)


suite : Test
suite =
    describe "食べ物を選択できる"
        [ test "チェックが付けられた食べ物は、リストの先頭に追加される" <|
            \_ ->
                let
                    model =
                        { selectedFoods = [ "りんご" ] }
                in
                update (UpdateFoods "バナナ" True) model
                    |> Tuple.first
                    |> .selectedFoods
                    |> Expect.equal
                        [ "バナナ", "りんご" ]
        , test "チェックが外された食べ物は、リストから除外される" <|
            \_ ->
                let
                    model =
                        { selectedFoods = [ "りんご", "焼き肉" ] }
                in
                update (UpdateFoods "焼き肉" False) model
                    |> Tuple.first
                    |> .selectedFoods
                    |> Expect.equal
                        [ "りんご" ]
        ]
