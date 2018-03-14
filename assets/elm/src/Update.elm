module Update exposing (update)

import Commands as Commands
import Messages exposing (Msg(..))
import Model exposing (..)
import Recaptcha.Update
import SubscribeForm.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            extractFormFields subscribeForm
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
                    ( { model
                        | subscribeForm = newSubscribeForm
                      }
                    , Commands.subscribe newSubscribeForm
                    )

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            LeadMsg msg ->
                SubscribeForm.Update.update msg model subscribeForm formFields
