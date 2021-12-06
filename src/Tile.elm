module Tile exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr


type alias Tile =
    { tileType : TileType
    , rotation : Rotation
    , item : Maybe Item
    }


type TileType
    = Straight
    | Cross
    | Angle


type Item
    = HomeBlue
    | HomeGreen
    | HomeRed
    | HomeYellow
    | Sword
    | Gem
    | Helmet
    | Candle
    | Chest
    | Ring
    | Skull
    | Keys
    | Crown
    | Map
    | Purse
    | Book
    | Troll
    | Fairy
    | Spirit
    | Dragon
    | Ghost
    | Bat
    | Rat
    | Spider
    | Lizard
    | Moth
    | Beetle
    | Owl


type Rotation
    = Deg0
    | Deg90
    | Deg180
    | Deg270


drawTile : Tile -> Html msg
drawTile tile =
    Html.div
        [ Attr.style "background-image" ("url(/images/tile-" ++ backgroundImage tile ++ ".svg)")
        , Attr.style "transform" ("rotate(" ++ tileRotation tile ++ "deg)")
        , Attr.style "display" "flex"
        , Attr.style "align-items" "center"
        , Attr.style "justify-content" "center"
        , Attr.style "width" "100px"
        , Attr.style "height" "100px"
        ]
        [ tileItem tile ]


backgroundImage : Tile -> String
backgroundImage { tileType } =
    case tileType of
        Straight ->
            "straight"

        Cross ->
            "cross"

        Angle ->
            "angle"


tileRotation : Tile -> String
tileRotation { rotation } =
    case rotation of
        Deg0 ->
            "0"

        Deg90 ->
            "90"

        Deg180 ->
            "180"

        Deg270 ->
            "270"


tileItem : Tile -> Html msg
tileItem { item } =
    let
        filename =
            case item of
                Just HomeBlue ->
                    "home-blue"

                Just HomeRed ->
                    "home-red"

                Just HomeYellow ->
                    "home-yellow"

                Just HomeGreen ->
                    "home-green"

                _ ->
                    ""
    in
    if filename /= "" then
        Html.img [ Attr.src ("images/item-" ++ filename ++ ".svg") ] []

    else
        Html.div [] []


type Direction
    = Up
    | Right
    | Down
    | Left


exits : Tile -> List Direction
exits { tileType, rotation } =
    case tileType of
        Straight ->
            case rotation of
                Deg0 ->
                    [ Left, Right ]

                Deg90 ->
                    [ Up, Down ]

                Deg180 ->
                    [ Left, Right ]

                Deg270 ->
                    [ Up, Down ]

        Cross ->
            case rotation of
                Deg0 ->
                    [ Left, Up, Right ]

                Deg90 ->
                    [ Up, Right, Down ]

                Deg180 ->
                    [ Right, Down, Left ]

                Deg270 ->
                    [ Down, Left, Up ]

        Angle ->
            case rotation of
                Deg0 ->
                    [ Up, Right ]

                Deg90 ->
                    [ Right, Down ]

                Deg180 ->
                    [ Down, Left ]

                Deg270 ->
                    [ Left, Up ]
