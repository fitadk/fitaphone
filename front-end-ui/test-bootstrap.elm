module Test1 exposing (..)
import Html exposing (..)
import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col

div []
    [ Button.button
            [ Button.outlineSuccess
                    , Button.attrs [ onClick <| ModalMsg Modal.visibleState ]
                            ]
                                    [ text "Open modal" ]
                                            , Modal.config ModalMsg
                                                        |> Modal.large
                                                                    |> Modal.h3 [] [ text "Modal grid header" ]
                                                                                |> Modal.body []
                                                                                                [ Grid.containerFluid [ ]
                                                                                                                    [ Grid.row [ ]
                                                                                                                                            [ Grid.col
                                                                                                                                                                        [ Col.sm4 ] [ text "Col sm4" ]
                                                                                                                                                                                                , Grid.col
                                                                                                                                                                                                                            [ Col.sm8 ] [ text "Col sm8" ]
                                                                                                                                                                                                                                                    ]
                                                                                                                                                                                                                                                                        , Grid.row [ ]
                                                                                                                                                                                                                                                                                                [ Grid.col
                                                                                                                                                                                                                                                                                                                            [ Col.md4 ] [ text "Col md4" ]
                                                                                                                                                                                                                                                                                                                                                    , Grid.col
                                                                                                                                                                                                                                                                                                                                                                                [ Col.md8 ] [ text "Col md8" ]
                                                                                                                                                                                                                                                                                                                                                                                                        ]
                                                                                                                                                                                                                                                                                                                                                                                                                            ]
                                                                                                                                                                                                                                                                                                                                                                                                                                            ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                        |> Modal.footer []
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        [ Button.button
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            [ Button.outlinePrimary
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                , Button.attrs [ onClick <| ModalMsg Modal.hiddenState ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        [ text "Close" ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |> Modal.view model.modalState
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ]