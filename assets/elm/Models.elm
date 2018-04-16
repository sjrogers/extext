module Models exposing (..)

type alias BrowserModel =
    { history : List String
    , available : List String
    }

type alias DirectoryModel =
    {
    files: List String
    }

type alias TextFileModel =
    { path : String
    , contents : List String
    }