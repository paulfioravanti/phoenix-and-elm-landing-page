port module Ports exposing (..)

-- Browser-bound (-> Cmd msg)


port initRecaptcha : String -> Cmd msg


port resetRecaptcha : () -> Cmd msg
