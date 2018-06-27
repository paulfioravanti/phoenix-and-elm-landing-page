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
            LeadMsg leadMsg ->
                Lead.Update.update leadMsg model formFields

            RecaptchaMsg recaptchaMsg ->
                Recaptcha.Update.update recaptchaMsg model formFields

            SubscribeFormMsg subscribeFormMsg ->
                SubscribeForm.Update.update subscribeFormMsg model formFields
