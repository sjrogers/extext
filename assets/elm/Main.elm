module Main exposing (..)

import Html
import Html.Events exposing (onClick)
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
    , current : TxtFile
    }
type alias TxtFile =
    { title: String
    , contents: String
    }
emptyTxtFile = TxtFile "Welcome" "Select a file."

type Msg =
    Populate (Result Http.Error TxtFileList)
    | Display TxtFile

init = ( Model [] [] emptyTxtFile, loadFiles )

-- view

fileEntry: TxtFile -> Html.Html Msg
fileEntry f =
--    Html.button [ onClick (Display f.contents) ] [Html.text f.title]
    Html.button [] [Html.text f.title]
contentsList files =
    (List.map (\x -> Html.li [] [fileEntry x]) files)

view model =
    let
        tableOfContents = Html.ul [] (contentsList model.available)
        header = Html.h2 [] [Html.text model.current.title]
        displayContainer = Html.div [] [Html.text model.current.contents]
    in
        Html.div [] [
            tableOfContents
            , header
            , displayContainer
        ]

-- update

update msg model =
    case msg of
        Populate (Ok txtFiles) ->
            let updatedModel = { model | available = txtFiles }
            in (updatedModel, Cmd.none)
--        Populate (Ok txtFiles) -> (Model txtFiles [], Cmd.none)
        Populate (Err e) -> (model, Cmd.none)
        Display txtFile -> init

-- JSON
type alias TxtFileList = List TxtFile
txtFileDecoder = map2 TxtFile (field "title" string) (field "contents" string)
txtFileListDecoder = list txtFileDecoder
loadFiles: Cmd Msg
loadFiles =
    let result = Http.get "/files" txtFileListDecoder
    in Http.send Populate result