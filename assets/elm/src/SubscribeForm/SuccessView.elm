module SubscribeForm.SuccessView exposing (view)

import Html exposing (Html, div, h2, i, p, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)


view : Html Msg
view =
    div [ class "success-message" ]
        [ div [ class "icon is-large" ]
            [ i [ class "fa fa-3x fa-heart" ] [] ]
        , h2 []
            [ text "You have subscribed with success" ]
        , p []
            [ text "We will keep you updated with the latest news" ]
        ]
