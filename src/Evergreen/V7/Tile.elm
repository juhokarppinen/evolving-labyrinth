module Evergreen.V7.Tile exposing (..)


type TileType
    = Straight
    | Cross
    | Angle


type Rotation
    = Deg0
    | Deg90
    | Deg180
    | Deg270


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


type alias Tile =
    { tileType : TileType
    , rotation : Rotation
    , item : Maybe Item
    }
