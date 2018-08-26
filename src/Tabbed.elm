module Tabbed exposing (..)

import Continue exposing (Continue(..))
import Html exposing (Html)
import Html.Events as Events


type alias Model a =
    { active : Maybe a
    , tabs : List a
    }


init : List a -> Model a
init items =
    { active = Nothing
    , tabs = items
    }


type Msg a
    = ChangeTab a
    | Close


update : Msg a -> Model a -> Model a
update msg model =
    case msg of
        ChangeTab a ->
            { model | active = Just a }

        Close ->
            { model | active = Nothing }


view : (Msg a -> msg) -> (a -> String) -> Model a -> Continue (Html msg) a
view msg toString { active, tabs } =
    Cont <|
        \k ->
            Html.div []
                [ Html.nav [] <|
                    List.map (viewBtn msg toString active) tabs
                , Html.main_ []
                    [ Maybe.map k active
                        |> Maybe.withDefault (Html.text "")
                    ]
                ]


viewBtn : (Msg a -> msg) -> (a -> String) -> Maybe a -> a -> Html msg
viewBtn msg toString active item =
    let
        isActive =
            active == Just item
    in
    Html.button
        [ Events.onClick <|
            msg <|
                if isActive then
                    Close
                else
                    ChangeTab item
        ]
        [ Html.text <| toString item ]
