module Main exposing (..)
import Browser

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)
--import Markdown
--main = div [] [text "MAIN", Browser.main]

main = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }

-- MODEL
--type alias Directory =
--    { dirpath : String
--    , files: List FileModel }
type alias FileModel =
    { path : String
    , contents: String
    }

init : (FileModel, Cmd Msg)
init =
    ( FileModel "test_md" "file body"
    , Cmd.none)
-- UPDATE
type Msg
    = ShowFile String
update : Msg -> FileModel -> (FileModel, Cmd Msg)
update msg model =
    case msg of
    ShowFile newFilepath ->
        { model | path = newFilepath } ! []
-- VIEW
browser = Browser.Browser [] ["NOT LOADED"]
brender f = p [] [text f]
view : FileModel -> Html Msg
view model =
    div [] [p [] [text "Working"]]
--    [ input [
--            placeholder "enter file name"
--            , autofocus True
----            , onSubmit ShowFile
--            ] []
--    , button [] [ text "Read file!" ]
--    , br [] []
--    , h1 [] [ text model.path ]
--    , p [] [ text model.contents ]
--    ]