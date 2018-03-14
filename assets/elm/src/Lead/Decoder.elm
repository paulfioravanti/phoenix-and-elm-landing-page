module Lead.Decoder exposing (successDecoder, errorsDecoder)

import Json.Decode as Decode exposing (dict, list, string)
import SubscribeForm.Model exposing (ValidationErrors)


{-|
As we do not care about the payload that the Phoenix LeadController returns
when the lead subscribes successfully, the `decoder` function decodes anything
received into a True value.
-}
successDecoder : Decode.Decoder Bool
successDecoder =
    Decode.succeed True


errorsDecoder : Decode.Decoder ValidationErrors
errorsDecoder =
    dict (list string)
