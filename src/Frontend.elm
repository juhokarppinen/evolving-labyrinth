module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html exposing (Html, text)
import Html.Attributes as Attr
import Html.Events as Events
import Lamdera
import Random
import Random.List
import Tile exposing (Item(..), Rotation(..), defaultTiles, drawTile, getTile)
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , message = "Welcome to the Evolving Labyrinth! This is a small hobby project for learning Elm with Lamdera."
      , tiles = []
      }
    , Random.generate ShuffleTiles (Random.List.shuffle defaultTiles)
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        NoOpFrontendMsg ->
            ( model, Cmd.none )

        Shuffle ->
            ( model, Random.generate ShuffleTiles (Random.List.shuffle defaultTiles) )

        ShuffleTiles tiles ->
            ( { model | tiles = tiles }
            , Random.generate RandomRotateTiles <|
                Random.list
                    (List.length tiles)
                    (Random.uniform Deg0 [ Deg90, Deg180, Deg270 ])
            )

        RandomRotateTiles rotations ->
            ( { model | tiles = List.map2 (\t r -> { t | rotation = r }) model.tiles rotations }
            , Cmd.none
            )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = ""
    , body =
        [ Html.div
            [ Attr.style "display" "flex"
            , Attr.style "flex-direction" "column"
            , Attr.style "align-items" "center"
            , Attr.style "justify-content" "center"
            , Attr.style "padding-top" "40px"
            ]
            [ Html.h1 [] [ Html.text "The Evolving Labyrinth" ]
            , drawLabyrinth model
            , Html.button [ Events.onClick Shuffle ] [ text "Regenerate" ]
            , Html.div
                [ Attr.style "font-family" "sans-serif"
                , Attr.style "padding-top" "40px"
                ]
                [ Html.text model.message ]
            ]
        ]
    }


drawLabyrinth : FrontendModel -> Html msg
drawLabyrinth model =
    Html.div
        [ Attr.style "display" "grid"
        , Attr.style "grid-template-columns" "repeat(7, 100px)"
        , Attr.style "grid-template-rows" "repeat(7, 100px)"
        , Attr.style "background-color" "#1111aa"
        , Attr.style "padding" "10px"
        , Attr.style "border-radius" "5px"
        ]
        ([ Tile.Tile Tile.Angle Tile.Deg90 (Just Tile.HomeBlue)
         , getTile 1 model.tiles
         , Tile.Tile Tile.Cross Tile.Deg180 (Just Tile.Helmet)
         , getTile 2 model.tiles
         , Tile.Tile Tile.Cross Tile.Deg180 (Just Tile.Candle)
         , getTile 3 model.tiles
         , Tile.Tile Tile.Angle Tile.Deg180 (Just Tile.HomeGreen)
         ]
            ++ (List.range 13 19 |> List.map (\n -> getTile n model.tiles))
            ++ [ Tile.Tile Tile.Cross Tile.Deg90 (Just Tile.Sword)
               , getTile 4 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg90 (Just Tile.Diamond)
               , getTile 5 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg180 (Just Tile.Chest)
               , getTile 6 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg270 (Just Tile.Ring)
               ]
            ++ (List.range 20 26 |> List.map (\n -> getTile n model.tiles))
            ++ [ Tile.Tile Tile.Cross Tile.Deg90 (Just Tile.Skull)
               , getTile 7 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg0 (Just Tile.Deed)
               , getTile 8 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg270 (Just Tile.Crown)
               , getTile 9 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg270 (Just Tile.Rabbit)
               ]
            ++ (List.range 27 33 |> List.map (\n -> Tile.rotate Tile.Deg90 (getTile n model.tiles)))
            ++ [ Tile.Tile Tile.Angle Tile.Deg0 (Just Tile.HomeRed)
               , getTile 10 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg0 (Just Tile.Purse)
               , getTile 11 model.tiles
               , Tile.Tile Tile.Cross Tile.Deg0 (Just Tile.Book)
               , getTile 12 model.tiles
               , Tile.Tile Tile.Angle Tile.Deg270 (Just Tile.HomeYellow)
               ]
            |> List.map drawTile
        )
