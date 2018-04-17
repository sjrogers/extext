module Browser.State exposing (..)

import Browser.Types exposing (..)
import WebSocket

init : (Model, Cmd Msg)
init = (Model [] ["NONE"], Cmd.none) -- TODO: command "load"

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadAvailable -> (Model [] ["Loading..."], Cmd.none)
        Clear -> init

subscriptions : Model -> Sub Msg
subscriptions model = WebSocket.listen "ws://echo.websocket.org"
--subscriptions _ = Sub.none