module Browser.Types exposing (..)

type Msg = Clear | LoadAvailable | LoadFile

type alias Model =
    { history : List String
    , available : List String
    }

--type alias DirectoryModel =
--    {
--    files: List String
--    }
--
--type alias TextFileModel =
--    { path : String
--    , contents : List String
--    }