module Messages exposing (Msg(..))

import Lead.Messages exposing (LeadMsg)
import Recaptcha.Messages exposing (RecaptchaMsg)


type Msg
    = FullNameChanged String
    | EmailChanged String
    | FormSubmitted
    | LeadMsg LeadMsg
    | RecaptchaMsg RecaptchaMsg
