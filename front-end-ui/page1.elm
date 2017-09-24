module Page1 exposing (main)

import List
import Http
import Json.Decode as Decode exposing (field, Decoder)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Table as Table


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model ShowUserList "0" [], doListUsers )



-- MODEL


type State
    = ShowUserList
    | ShowCreateUser


type alias User =
    { name : String
    , tlf : String
    , date : String
    }


type alias Model =
    { state : State
    , lastRequestCode : String
    , users : List User
    }



-- model : Model
-- model =
--    { state = ShowUserList, lastRequestCode = "0", users = [] }
-- UPDATE


type Msg
    = List
    | Create
    | CreateUser
    | UserCreated (Result Http.Error String)
    | UpdateUserList (Result Http.Error (List User))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        List ->
            ( { model | state = ShowUserList }, Cmd.none )

        Create ->
            ( { model | state = ShowCreateUser }, Cmd.none )

        CreateUser ->
            ( model, doCreateUser model )

        UserCreated (Ok lastReqCode) ->
            ( { model | lastRequestCode = lastReqCode }, doListUsers )

        UserCreated (Err _) ->
            ( { model | state = ShowUserList }, Cmd.none )

        UpdateUserList (Ok list) ->
            ( { model | state = ShowUserList, users = list }, Cmd.none )

        UpdateUserList (Err _) ->
            ( { model | state = ShowUserList }, Cmd.none )



-- VIEW


renderUserList : List User -> List (Table.Row msg)
renderUserList users =
    List.map
        (\i ->
            Table.tr []
                [ Table.td [] [ text i.name ]
                , Table.td [] [ text i.tlf ]
                , Table.td [] [ text i.date ]
                ]
        )
        users


rightStyle : Html.Attribute msg
rightStyle =
    style
        [ ( "text-align", "right" )
        , ( "width", "100%" )
        , ( "margin", "10px" )
        ]


userListView : Model -> Html Msg
userListView model =
    div []
        [ CDN.stylesheet
        , Grid.container []
            [ Button.button [ Button.primary, Button.onClick Create ] [ text "Opret bruger" ]
            , div [ rightStyle ] [ text ("Antal brugere: " ++ toString (List.length model.users)) ]
            , Table.table
                { options = [ Table.striped, Table.hover ]
                , thead =
                    Table.simpleThead
                        [ Table.th [] [ text "Brugernavn" ]
                        , Table.th [] [ text "Telefonnumer" ]
                        , Table.th [] [ text "Senest aktiv" ]
                        ]
                , tbody =
                    Table.tbody []
                        (renderUserList
                            model.users
                        )
                }
            ]
        ]


createUserView : Model -> Html Msg
createUserView model =
    div []
        [ CDN.stylesheet
        , Grid.container []
            [ Form.form []
                [ h4 [] [ text "Opret FITA Phone bruger" ]
                , Form.group []
                    [ Form.label [] [ text "Brugernavn" ]
                    , Input.text [ Input.attrs [ placeholder "fx hansjensen" ] ]
                    ]
                , Form.group []
                    [ Form.label [] [ text "Telefonnummer" ]
                    , Input.text [ Input.attrs [ placeholder "fx 3555" ] ]
                    ]
                , Form.group []
                    [ Form.label [] [ text "Email" ]
                    , Input.text [ Input.attrs [ placeholder "fx hjensen@domain.dk" ] ]
                    ]
                , Form.row [ Row.rightSm ]
                    [ Form.col [ Col.sm2 ]
                        [ Button.button [ Button.secondary, Button.onClick List ]
                            [ text "Annullere" ]
                        ]
                    , Form.col [ Col.sm2 ]
                        [ Button.button
                            [ Button.primary, Button.attrs [ class "float-right" ], Button.onClick CreateUser ]
                            [ text "Opret" ]
                        ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    case model.state of
        ShowUserList ->
            userListView model

        ShowCreateUser ->
            createUserView model



-- LOGIC


getUsers : Model -> Cmd Msg
getUsers model =
    Cmd.none


doCreateUser : Model -> Cmd Msg
doCreateUser model =
    let
        url =
            "http://localhost:8000/testok.json"
    in
        Http.send UserCreated (Http.get url decodeUserData)


decodeUserData : Decoder String
decodeUserData =
    Decode.at [ "statusCode" ] Decode.string


doListUsers : Cmd Msg
doListUsers =
    let
        url =
            "http://localhost:8000/testuserlist.json"
    in
        Http.send UpdateUserList (Http.get url decodeUserListData)


decodeUserListData : Decoder (List User)
decodeUserListData =
    Decode.list userDecoder


userDecoder : Decoder User
userDecoder =
    Decode.map3 User
        (field "username" Decode.string)
        (field "phonenumber" Decode.string)
        (field "lastactive" Decode.string)
