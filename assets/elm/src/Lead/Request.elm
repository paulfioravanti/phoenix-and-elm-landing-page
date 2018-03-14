module Lead.Request exposing (submitLead)

import Http
import Lead.Decoder
import Lead.Encoder
import SubscribeForm.Model exposing (FormFields)


submitLead : FormFields -> Http.Request Bool
submitLead formFields =
    Http.request
        { method = "POST"
        , headers = []
        , url = "/api/v1/leads"
        , body = Http.jsonBody (Lead.Encoder.encoder formFields)
        , expect = Http.expectJson Lead.Decoder.decoder
        , timeout = Nothing
        , withCredentials = False
        }
