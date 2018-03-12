port module Recaptcha.Subscriptions exposing (setRecaptchaToken)

-- Elm-bound (-> Sub msg)


port setRecaptchaToken : (String -> msg) -> Sub msg
