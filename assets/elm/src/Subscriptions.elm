module Subscriptions exposing (subscriptions)

import Messages exposing (Msg, Msg(RecaptchaMsg))
import Model exposing (Model)
import Recaptcha.Messages exposing (RecaptchaMsg(SetRecaptchaToken))
import Recaptcha.Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    SetRecaptchaToken
        |> Recaptcha.Subscriptions.setRecaptchaToken
        |> Sub.map RecaptchaMsg
