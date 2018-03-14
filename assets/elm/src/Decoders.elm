module Decoders exposing (validationErrorsDecoder)

import Json.Decode as Decode exposing (dict, list, string)
import SubscribeForm.Model exposing (ValidationErrors)


validationErrorsDecoder : Decode.Decoder ValidationErrors
validationErrorsDecoder =
    dict (list string)
