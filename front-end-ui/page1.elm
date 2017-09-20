module Page1 exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Bootstrap.CDN as CDN
import Bootstrap.Button as Button


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type State
    = UserList
    | CreateUser


type alias Model =
    State


model : Model
model =
    UserList



-- UPDATE


type Msg
    = List
    | Create


update : Msg -> Model -> Model
update msg model =
    case msg of
        List ->
            UserList

        Create ->
            CreateUser



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        UserList ->
            div []
                [ CDN.stylesheet
                , Button.button [ Button.primary, Button.onClick Create ] [ text "Opret bruger" ]
                , div []
                    [ table []
                        [ thead []
                            [ th [] [ text "Bruger navn" ]
                            , th [] [ text "Telefoner nr" ]
                            , th [] [ text "Seneste aktiv" ]
                            ]
                        ]
                    ]
                ]

        CreateUser ->
            div []
                [ div []
                    [ text "bruger navn"
                    , input [ type_ "text" ] []
                    ]
                , div []
                    [ text "Telefonnr"
                    , input [ type_ "text" ] []
                    ]
                , button [ onClick List ] [ text "opret!" ]
                ]
