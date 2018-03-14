module Update exposing (update)

import Commands
import Messages
    exposing
        ( Msg
            ( FullNameChanged
            , EmailChanged
            , FormSubmitted
            , RecaptchaMsg
            , LeadMsg
            )
        )
import Model exposing (Model, SubscribeForm(Editing, Saving))
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
            FullNameChanged value ->
                ( { model
                    | subscribeForm = Editing { formFields | fullName = value }
                  }
                , Cmd.none
                )

            EmailChanged value ->
                ( { model
                    | subscribeForm = Editing { formFields | email = value }
                  }
                , Cmd.none
                )

            FormSubmitted ->
                let
                    newSubscribeForm =
                        Saving formFields
                in
                    ( { model | subscribeForm = newSubscribeForm }
                    , Commands.subscribe newSubscribeForm
                    )

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            LeadMsg msg ->
                SubscribeForm.Update.update msg model subscribeForm formFields
