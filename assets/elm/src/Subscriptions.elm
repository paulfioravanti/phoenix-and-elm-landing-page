port module Subscriptions exposing (setRecaptchaToken)


port setRecaptchaToken : (String -> msg) -> Sub msg
