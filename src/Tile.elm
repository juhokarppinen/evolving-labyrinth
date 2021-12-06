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
    | Armor
    | Book
    | Butterfly
    | Candle
    | Cat
    | Chest
    | Chicken
    | Crown
    | Deed
    | Diamond
    | Dog
    | Fairy
    | Fish
    | Frog
    | Ghost
    | Helmet
    | Horse
    | Lion
    | Pig
    | Purse
    | Rabbit
    | Ring
    | Skull
    | Sword
    | Turtle
    | Wasp


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

                Just Armor ->
                    "armor"

                Just Book ->
                    "book"

                Just Butterfly ->
                    "butterfly"

                Just Candle ->
                    "candle"

                Just Cat ->
                    "cat"

                Just Chest ->
                    "chest"

                Just Chicken ->
                    "chicken"

                Just Crown ->
                    "crown"

                Just Deed ->
                    "deed"

                Just Diamond ->
                    "diamond"

                Just Dog ->
                    "dog"

                Just Fairy ->
                    "fairy"

                Just Fish ->
                    "fish"

                Just Frog ->
                    "frog"

                Just Ghost ->
                    "ghost"

                Just Helmet ->
                    "helmet"

                Just Horse ->
                    "horse"

                Just Lion ->
                    "lion"

                Just Pig ->
                    "pig"

                Just Purse ->
                    "purse"

                Just Rabbit ->
                    "rabbit"

                Just Ring ->
                    "ring"

                Just Skull ->
                    "skull"

                Just Sword ->
                    "sword"

                _ ->
                    ""
    in
    if filename /= "" then
        Html.img
            [ Attr.src ("/images/item-" ++ filename ++ ".svg")
            , Attr.style "max-width" "50px"
            , Attr.style "max-height" "50px"
            , Attr.style "filter" "drop-shadow(0 0 2px black) "
            ]
            []

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


defaultItemTiles : List Tile
defaultItemTiles =
    [ Tile Angle Deg0 (Just Butterfly)
    , Tile Angle Deg0 (Just Cat)
    , Tile Angle Deg0 (Just Chicken)
    , Tile Angle Deg0 (Just Dog)
    , Tile Angle Deg0 (Just Fairy)
    , Tile Angle Deg0 (Just Fish)
    , Tile Cross Deg0 (Just Frog)
    , Tile Cross Deg0 (Just Ghost)
    , Tile Cross Deg0 (Just Horse)
    , Tile Cross Deg0 (Just Lion)
    , Tile Cross Deg0 (Just Pig)
    , Tile Cross Deg0 (Just Armor)
    ]


defaultPlainTiles : List Tile
defaultPlainTiles =
    List.repeat 10 (Tile Angle Deg0 Nothing) ++ List.repeat 12 (Tile Straight Deg0 Nothing)


defaultTiles : List Tile
defaultTiles =
    defaultItemTiles ++ defaultPlainTiles


getTile n list =
    let
        item =
            list |> List.drop (n - 1) |> List.head
    in
    case item of
        Just x ->
            x

        Nothing ->
            Tile Angle Deg0 Nothing


rotate : Rotation -> Tile -> Tile
rotate rotation tile =
    { tile | rotation = rotation }
