module Lead.Decoder exposing (decoder)

import Json.Decode as Decode


{-|
As we do not care about the payload that the Phoenix LeadController returns
when the lead subscribes successfully, the `decoder` function decodes anything
received into a True value.
-}
decoder : Decode.Decoder Bool
decoder =
    Decode.succeed True
