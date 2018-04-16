module Views exposing (..)

import Models exposing (TextFileModel)
import Html exposing (div, text)

type alias Model = TextFileModel

textFileView : Model -> Html Msg
textFileView model =
    div [] [ text (toString model) ]