module Messages exposing (Msg(..))

import Http
import Recaptcha.Messages exposing (RecaptchaMsg)


type Msg
    = HandleFullNameInput String
    | HandleEmailInput String
    | HandleFormSubmit
    | SubscribeResponse (Result Http.Error Bool)
    | RecaptchaMsg RecaptchaMsg
