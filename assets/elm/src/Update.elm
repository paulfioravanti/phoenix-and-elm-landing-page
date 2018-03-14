module Update exposing (update)

import Lead.Update
import Messages exposing (Msg(LeadMsg, RecaptchaMsg, SubscribeFormMsg))
import Model exposing (Model)
import Recaptcha.Update
import SubscribeForm.Update
import SubscribeForm.Utilities


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        formFields =
            model
                |> .subscribeForm
                |> SubscribeForm.Utilities.extractFormFields
    in
        case msg of
            LeadMsg msg ->
                Lead.Update.update msg model formFields

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model formFields

            SubscribeFormMsg msg ->
                SubscribeForm.Update.update msg model formFields
