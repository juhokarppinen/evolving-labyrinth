module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Tile exposing (Rotation, Tile)
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    , tiles : List Tile
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | Shuffle
    | ShuffleTiles (List Tile)
    | RandomRotateTiles (List Rotation)


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
