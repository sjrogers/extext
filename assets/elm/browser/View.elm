module Browser.Views exposing (root)

import Browser.Types exposing (Model, Msg)
import Html exposing (Html, div, text)

root : Model -> Html Msg
root model =
    div [] [ text (toString model) ]

--textFileView : Model -> Html Msg
--textFileView model =
--    div [] [ text (toString model) ]