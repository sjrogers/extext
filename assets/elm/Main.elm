module Main exposing (..)

import Html exposing (text, h2, h3, div, ul, li)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)
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
        fileEntry f =
            Html.button
            [ attribute "class" "btn"
            , onClick (Display f) ]
            [text f.title]
        fileLi f =
            li [] [fileEntry f]
    in
        (List.map fileLi files)

view model =
    let
        tableOfContents =
            ul
            [ attribute "class" "extextMenu" ]
            (contentsList model.available)
        tableOfContentsDiv =
            div
            [ attribute "class" "col-md-4" ]
            [ tableOfContents]
        header =
            h2
            [ attribute "class" "text-right" ]
            [text model.current.title]
        txtFileContentsDiv =
            div
            []
            [text model.current.contents]
        displayContainer = div
            [ attribute "class" "col-md-8 pull-right" ]
            [ header, txtFileContentsDiv ]
    in
        div
        [ attribute "class" "row" ]
        [
            tableOfContentsDiv
            , displayContainer
        ]

-- update

update msg model =
    case msg of
        -- if file list loads successfully
        Populate (Ok txtFiles) ->
            let
                updatedModel = { model | available = txtFiles }
            in
                (updatedModel, Cmd.none)
        -- if an error occurs in loading file list
        Populate (Err _) ->
            let
                errorFile = TxtFile "Error!" "Could not load files."
                errorModel = { model | current = errorFile }
            in
                (errorModel, Cmd.none)
        -- display specified text file
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