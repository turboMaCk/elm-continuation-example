module Main exposing (..)

import Browser
import Continue exposing (Continue(..))
import Html exposing (Html)
import Html.Events as Events
import Tabbed


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type Item
    = First
    | Second
    | Third


toString : Item -> String
toString item =
    case item of
        First ->
            "first"

        Second ->
            "second"

        Third ->
            "third"


type alias Model =
    { tabbed : Tabbed.Model Item }


init : Model
init =
    Tabbed.init [ First, Second, Third ]
        |> Model


type Msg
    = TabbedMsg (Tabbed.Msg Item)


update : Msg -> Model -> Model
update (TabbedMsg msg) model =
    { model | tabbed = Tabbed.update msg model.tabbed }


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "This app is composed using continuations" ]
        , Tabbed.view TabbedMsg toString model.tabbed
            |> Continue.run viewContent
        ]


viewContent : Item -> Html msg
viewContent item =
    case item of
        First ->
            Html.strong [] [ Html.text "This is the first item" ]

        Second ->
            Html.text "This is second one though!"

        Third ->
            Html.table []
                [ Html.tr [] [ Html.td [] [ Html.text "third" ], Html.td [] [ Html.text "item" ] ] ]
