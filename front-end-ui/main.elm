module Main exposing (..)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button
import Bootstrap.Table as Table
import Bootstrap.Modal as Modal
import Bootstrap.Form.Input as Input


type alias Model =
    { modalState : Modal.State }


init : ( Model, Cmd Msg )
init =
    ( { modalSate = Modal.hiddenState }, Cmd.none )


type Msg
    = ModalMsg Modal.State


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ModelMsg state ->
            ( { model | modalState = state }, Cmd.none )


view : Model -> Html msg
view model =
    Grid.container []
        [ CDN.stylesheet
        , Grid.row []
            [ Grid.col []
                [ Button.button [ Button.primary, Button.onClick ModalMsg Modal.visibleState ] [ text "Opret bruger" ] ]
            , Modal.config ModalMsg
                Modal.small
                Modal.h3
                []
                [ text "Opret bruger" ]
                Modal.body
                []
                [ Grid.containerFluid []
                    [ Grid.row []
                        [ Grid.col [ Col.sm4 ] [ text "Brugername" ]
                        , Grid.col [ Col.sm8 ] [ Input.text [ Input.attrs [ placeholder "brugernavn" ] ] ]
                        ]
                    , Grid.row []
                        [ Grid.col [ Col.sm4 ] [ text "Telefon nummer" ]
                        , Grid.col [ Col.sm8 ] [ Input.text [ Input.attrs [ placeholder "000" ] ] ]
                        ]
                    , Grid.row []
                        [ Grid.col [ Col.sm4 ] [ text "For- og efternavn" ]
                        , Grid.col [ Col.sm8 ] [ Input.text [ Input.attrs [ placeholder "Hans Peter Jensen" ] ] ]
                        ]
                    , Grid.row []
                        [ Grid.col [ Col.sm4 ] [ text "Adresse" ]
                        , Grid.col [ Col.sm8 ] [ Input.text [ Input.attrs [ placeholder "et eller andet vej 555" ] ] ]
                        ]
                    ]
                ]
                Modal.footer
                []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attr [ onClick ModalMsg Modal.hiddenState ]
                    ]
                    [ text "Close" ]
                ]
                Modal.view
                model.modalState
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
