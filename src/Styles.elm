module Styles exposing (..)

import Html.Attributes as Attr


flex =
    Attr.style "display" "flex"


row =
    Attr.style "flex-direction" "row"


column =
    Attr.style "flex-direction" "column"


alignCenter =
    Attr.style "align-items" "center"


alignStart =
    Attr.style "align-items" "flex-start"


justifyCenter =
    Attr.style "justify-content" "center"


flexColumnCenter =
    [ flex, column, alignCenter, justifyCenter ]


flexRowCenter =
    [ flex, row, alignCenter, justifyCenter ]


paddingTop p =
    Attr.style "padding-top" p


paddingLeft p =
    Attr.style "padding-left" p
