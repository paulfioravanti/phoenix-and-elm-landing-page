module Recaptcha.Update exposing (update)

import Messages exposing (Msg)
import Model exposing (Model)
import Recaptcha.Messages exposing (RecaptchaMsg(SetRecaptchaToken))
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm
        , SubscribeForm(Editing)
        )


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
