module Main exposing (Msg(..), main, update)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { selectedFoods : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { selectedFoods = [] }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = UpdateFoods String Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFoods food isChecked ->
            let
                updatedFoods =
                    if isChecked then
                        food :: model.selectedFoods

                    else
                        List.filter (\f -> not <| f == food) model.selectedFoods
            in
            ( { model | selectedFoods = updatedFoods }, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    { title = "チェックボックス"
    , body =
        [ div [ class "form" ] <|
            h2 [] [ text "食べ物を選んでください" ]
                :: (foods
                        |> List.concatMap
                            (\food ->
                                [ input
                                    [ type_ "checkbox"
                                    , name "foods"
                                    , value food
                                    , onCheck <| UpdateFoods food
                                    ]
                                    []
                                , label [ style "margin-right" "22px" ] [ text food ]
                                ]
                            )
                   )
        , div []
            [ h2 [] [ text "選ばれた食べ物" ]
            , span [] [ text <| String.join ", " model.selectedFoods ]
            ]
        ]
    }


foods =
    [ "焼き肉", "ステーキ", "寿司", "アクアパッツァ", "りんご", "バナナ" ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
