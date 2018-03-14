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
import Model exposing (Model, SubscribeForm(Saving))
import Recaptcha.Update
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

            SubscribeFormMsg msg ->
                SubscribeForm.Update.update msg model formFields

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            LeadMsg msg ->
                Lead.Update.update msg model subscribeForm formFields
