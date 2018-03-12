port module Recaptcha.Ports exposing (initRecaptcha, resetRecaptcha)

-- Browser-bound (-> Cmd msg)


port initRecaptcha : String -> Cmd msg


port resetRecaptcha : () -> Cmd msg
