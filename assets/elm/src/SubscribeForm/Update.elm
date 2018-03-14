module SubscribeForm.Update exposing (update)

import Commands
import Messages exposing (Msg)
import Model exposing (Model)
import SubscribeForm.Messages
    exposing
        ( SubscribeFormMsg(EmailChanged, FormSubmitted, FullNameChanged)
        )
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm
        , SubscribeForm(Editing, Saving)
        )


update :
    SubscribeFormMsg
    -> Model
    -> FormFields
    -> ( Model, Cmd Msg )
update msg model formFields =
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
