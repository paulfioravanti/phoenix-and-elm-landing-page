module Update exposing (update)

import Commands
import Lead.Update
import Messages
    exposing
        ( Msg
            ( FormSubmitted
            , LeadMsg
            , RecaptchaMsg
            , SubscribeFormMsg
            )
        )
import Model exposing (Model)
import Recaptcha.Update
import SubscribeForm.Model exposing (SubscribeForm(Saving))
import SubscribeForm.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            Model.extractFormFields subscribeForm
    in
        case msg of
            FormSubmitted ->
                let
                    newSubscribeForm =
                        Saving formFields
                in
                    ( { model | subscribeForm = newSubscribeForm }
                    , Commands.subscribe newSubscribeForm
                    )

            LeadMsg msg ->
                Lead.Update.update msg model subscribeForm formFields

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            SubscribeFormMsg msg ->
                SubscribeForm.Update.update msg model formFields
