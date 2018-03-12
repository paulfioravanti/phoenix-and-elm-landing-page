module Main exposing (main)

import Html
import Messages exposing (Msg)
import Model exposing (Model)
import Recaptcha.Ports
import Subscriptions
import Update
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }


{-|
  "recaptcha" is the id of the HTML container where we want to render the widget
-}
init : ( Model, Cmd Msg )
init =
    ( Model.initialModel, Recaptcha.Ports.initRecaptcha "recaptcha" )
