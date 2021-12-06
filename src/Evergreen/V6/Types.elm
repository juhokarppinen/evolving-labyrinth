module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V6.Tile
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , tiles : List Evergreen.V6.Tile.Tile
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOpFrontendMsg
    | Shuffle
    | ShuffleTiles (List Evergreen.V6.Tile.Tile)
    | RandomRotateTiles (List Evergreen.V6.Tile.Rotation)


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
