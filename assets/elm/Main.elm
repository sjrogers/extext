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
    Populate (Result Http.Error (List TxtFile))
    | Display TxtFile

init = ( Model [] [] emptyTxtFile, loadFiles )

-- view

contentsList files =
    let
        fileEntry f =  Html.button [ onClick (Display f) ] [Html.text f.title]
        fileLi f = Html.li [] [fileEntry f]
    in
        (List.map fileLi files)

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
        Populate (Err _) ->
            let
                errorFile = TxtFile "Error!" "Could not load files."
                errorModel = { model | current = errorFile }
            in
                (errorModel, Cmd.none)
        Display txtFile ->
            let
                fileModel = { model | current = txtFile }
            in
                (fileModel, Cmd.none)

-- JSON

loadFiles: Cmd Msg
loadFiles =
    let
        txtFileDecoder =
            map2 TxtFile
                (field "title" string)
                (field "contents" string)
        result = Http.get "/files" (list txtFileDecoder)
    in
        Http.send Populate result