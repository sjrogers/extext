module Main exposing (..)

import Html
import Json.Decode exposing (map2, field, string, list)
import Http
import Result exposing (Result(Ok))

main = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none }

type alias Model =
    { available : List TxtFile
    , history : List String
    }

type Msg =
    Populate (Result Http.Error TxtFileList)
    | Display String

init = ( Model [] [], loadFiles )

view model = Html.div [] [ Html.text (toString model) ]
update msg model =
    case msg of
        Populate (Ok txtFiles) -> (Model txtFiles [], Cmd.none)
        Populate (Err e) -> (model, Cmd.none)
        Display title -> init

-- JSON
type alias TxtFile =
    { title: String
    , contents: String
    }
type alias TxtFileList = List TxtFile
txtFileDecoder = map2 TxtFile (field "title" string) (field "contents" string)
txtFileListDecoder = list txtFileDecoder
loadFiles: Cmd Msg
loadFiles =
    let result = Http.get "/files" txtFileListDecoder
    in Http.send Populate result