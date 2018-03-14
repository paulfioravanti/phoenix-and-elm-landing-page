module Messages exposing (Msg(..))

import Lead.Messages exposing (LeadMsg)
import Recaptcha.Messages exposing (RecaptchaMsg)
import SubscribeForm.Messages exposing (SubscribeFormMsg)


type Msg
    = SubscribeFormMsg SubscribeFormMsg
    | LeadMsg LeadMsg
    | RecaptchaMsg RecaptchaMsg
