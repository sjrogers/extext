module Main exposing (..)

import Html
import Json.Decode
import Http

main = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none }

type alias Model =
    { available : List String
    , history : List String
    }

type Msg = Clear | Populate | Display

init = ( Model [] [], Cmd.none )

view model = Html.div [] [ Html.text (toString model) ]
update msg model =
    case msg of
        Clear -> init
        Populate -> (Model ["loading"] [], Cmd.none)
        Display -> init