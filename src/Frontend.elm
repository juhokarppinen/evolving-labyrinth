module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html exposing (Html)
import Html.Attributes as Attr
import Lamdera
import Tile exposing (Item(..), drawTile)
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
      }
    , Cmd.none
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
            , drawLabyrinth
            , Html.div
                [ Attr.style "font-family" "sans-serif"
                , Attr.style "padding-top" "40px"
                ]
                [ Html.text model.message ]
            ]
        ]
    }


drawLabyrinth : Html msg
drawLabyrinth =
    Html.div
        [ Attr.style "display" "grid"
        , Attr.style "grid-template-columns" "repeat(7, 100px)"
        , Attr.style "grid-template-rows" "repeat(7, 100px)"
        , Attr.style "background-color" "#1111aa"
        , Attr.style "padding" "10px"
        , Attr.style "border-radius" "5px"
        ]
        ([ drawTile (Tile.Tile Tile.Angle Tile.Deg90 (Just Tile.HomeBlue))
         , Html.div [] []
         , drawTile (Tile.Tile Tile.Cross Tile.Deg180 Nothing)
         , Html.div [] []
         , drawTile (Tile.Tile Tile.Cross Tile.Deg180 Nothing)
         , Html.div [] []
         , drawTile (Tile.Tile Tile.Angle Tile.Deg180 (Just Tile.HomeGreen))
         ]
            ++ List.repeat 7 (Html.div [] [])
            ++ [ drawTile (Tile.Tile Tile.Cross Tile.Deg90 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg90 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg180 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg270 Nothing)
               ]
            ++ List.repeat 7 (Html.div [] [])
            ++ [ drawTile (Tile.Tile Tile.Cross Tile.Deg90 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg0 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg270 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg270 Nothing)
               ]
            ++ List.repeat 7 (Html.div [] [])
            ++ [ drawTile (Tile.Tile Tile.Angle Tile.Deg0 (Just HomeRed))
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg0 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Cross Tile.Deg0 Nothing)
               , Html.div [] []
               , drawTile (Tile.Tile Tile.Angle Tile.Deg270 (Just HomeYellow))
               ]
        )
