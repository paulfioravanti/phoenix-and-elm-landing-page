module Recaptcha.Update exposing (update)

import Messages exposing (Msg)
import Model exposing (Model, FormFields, SubscribeForm, SubscribeForm(Editing))
import Recaptcha.Messages exposing (RecaptchaMsg(SetRecaptchaToken))


update :
    RecaptchaMsg
    -> Model
    -> SubscribeForm
    -> FormFields
    -> ( Model, Cmd Msg )
update msg model subscribeForm formFields =
    case msg of
        SetRecaptchaToken token ->
            ( { model
                | subscribeForm =
                    Editing { formFields | recaptchaToken = Just token }
              }
            , Cmd.none
            )
