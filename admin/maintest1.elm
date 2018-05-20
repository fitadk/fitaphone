module MainiTest1 exposing (main)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button


main =
     Html.beginnerProgram( view = view, update = update )


-- The modal uses view state that you should keep track of in your model

type alias Model =
                { modalState : Modal.State }


-- Initialize your model

init : ( Model, Cmd Msg )
init =
            ( { modalState : Modal.hiddenState}, Cmd.none )


-- Define a message for your modal

type Msg
    = ModalMsg Modal.State


-- Handle modal messages in your update function

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
            case msg of
                 ModelMsg state ->
                     ( { model | modalState = state } , Cmd.none )


-- Configure your modal view using pipeline friendly functions.

view : Model -> Html msg
view model =
      Grid.container []
              [ CDN.stylesheet, Button.button
                     [ Button.outlineSuccess
                     , Button.attrs [ onClick <| ModalMsg Modal.visibleState} ]
                     ]
                     [ text "Open modal"]
             , Modal.config ModalMsg
                             |> Modal.small
                             |> Modal.h3 [] [ text "Modal header" ]
                             |> Modal.body [] [ p [] [ text "This is a modal for you !"] ]
                             |> Modal.footer []
                                     [ Button.button
                                             [ Button.outlinePrimary
                                             , Button.attrs [ onClick <| toMsg { state | modalState = Modal.hiddenState} ]
                                             ]
                                             [ text "Close" ]
                                     ]
                             |> Modal.view model.modalState
              ]


