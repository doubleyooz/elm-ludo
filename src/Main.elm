module Main exposing (main)

import Browser
import Cell exposing (cell, safeCell)
import HomeBox exposing (homeBox)
import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (Model, Msg(..), PlayerColour(..), Position(..))
import Random


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { diceNum = 0
      , turn = Red
      , positions = [ ( Red, 2 ) ]
      , maxPlayers = Just 2
      , room = Nothing
      , roomToJoin = ""
      , messageToDisplay = ""
      , selectedPlayer = Red
      , participants = [ Red, Green, Yellow, Blue ]
      }
    , Cmd.none
    )


lineHtml : String -> String -> Int -> Html Msg
lineHtml colour direction id =
    case id of
        0 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing "white" Nothing
                , safeCell [ "red", "blue" ] colour (Just "-700")
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                ]

        1 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing "white" Nothing
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                ]

        2 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , safeCell [ "red", "green", "blue" ] colour (Just "-700")
                , cell Nothing "white" Nothing
                ]

        3 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing colour (Just "-700")
                , cell Nothing "white" Nothing
                ]

        _ ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                , cell Nothing "white" Nothing
                ]


gridHtml : Model -> Html Msg
gridHtml model =
    div [ class "flex flex-colum p-5" ]
        [ div
            []
            [ homeBox [ True, True, True, True ] Blue
            , div [ class "col" ]
                [ lineHtml "blue" "row" 0
                , lineHtml "blue" "row" 1
                , lineHtml "blue" "row" 4
                ]
            , homeBox [ True, True, True, True ] Red
            ]
        , div
            [ class "col" ]
            [ div [ class "flex" ]
                [ lineHtml "yellow" "col" 4
                , lineHtml "yellow" "col" 1
                , lineHtml "yellow" "col" 0
                ]
            , div [ class "w-48 h-48" ] []
            , div [ class "flex" ]
                [ lineHtml "red" "col" 2
                , lineHtml "red" "col" 3
                , lineHtml "red" "col" 4
                ]
            ]
        , div
            []
            [ homeBox [ True, True, True, True ]
                Yellow
            , div []
                [ lineHtml "green" "row" 4
                , lineHtml "green" "row" 3
                , lineHtml "green" "row" 2
                ]
            , homeBox [ True, True, True, True ] Green
            ]
        ]


gameStartView model =
    div [ class " w-10 w-full  " ]
        []


view : Model -> Html Msg
view model =
    div []
        [ div [] [ Html.text model.messageToDisplay ]
        , case model.room of
            Just _ ->
                div []
                    [ div [ class "my-8  text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]

            Nothing ->
                div []
                    [ div [ class "my-8  text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]
        ]
