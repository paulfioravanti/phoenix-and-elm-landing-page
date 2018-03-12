module Decoders exposing (postResponseDecoder, validationErrorsDecoder)

import Json.Decode as Decode
import Model exposing (ValidationErrors)


postResponseDecoder : Decode.Decoder Bool
postResponseDecoder =
    Decode.succeed True


validationErrorsDecoder : Decode.Decoder ValidationErrors
validationErrorsDecoder =
    Decode.dict (Decode.list Decode.string)
