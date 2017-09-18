module Main exposing (..)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button
import Bootstrap.Table as Table


type Msg
    = CreateUser
    | CancelCreateUser


type alias Model =
    Int


model : Model
model =
    0


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreateUser ->
            model + 1

        CancelCreateUser ->
            model - 1


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet
        , Grid.row []
            [ Grid.col []
                [ Button.button [ Button.primary ] [ text "Opret bruger" ] ]
            ]
        , Grid.row []
            [ Grid.col []
                [ Table.simpleTable
                    ( Table.simpleThead
                        [ Table.th [] [ text "Brugernavn" ]
                        , Table.th [] [ text "Telefonnr" ]
                        , Table.th [] [ text "Senest aktiv" ]
                        ]
                    , Table.tbody []
                        [ Table.tr []
                            [ Table.td [] [ text "hugo" ]
                            , Table.td [] [ text "100" ]
                            , Table.td [] [ text "8/10-17" ]
                            ]
                        ]
                    )
                ]
            ]
        ]


main =
    Html.beginnerProgram { model = model, view = view, update = update }
