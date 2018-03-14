module Update exposing (update)

import Lead.Update
import Messages
    exposing
        ( Msg
            ( LeadMsg
            , RecaptchaMsg
            , SubscribeFormMsg
            )
        )
import Model exposing (Model)
import Recaptcha.Update
import SubscribeForm.Update
import SubscribeForm.Utilities


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            SubscribeForm.Utilities.extractFormFields subscribeForm
    in
        case msg of
            LeadMsg msg ->
                Lead.Update.update msg model subscribeForm formFields

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            SubscribeFormMsg msg ->
                SubscribeForm.Update.update msg model formFields
