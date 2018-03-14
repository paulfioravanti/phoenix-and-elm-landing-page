module SubscribeForm.Update exposing (update)

import Messages exposing (Msg)
import Model exposing (Model, FormFields, SubscribeForm, SubscribeForm(Editing))
import SubscribeForm.Messages
    exposing
        ( SubscribeFormMsg(EmailChanged, FullNameChanged)
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
