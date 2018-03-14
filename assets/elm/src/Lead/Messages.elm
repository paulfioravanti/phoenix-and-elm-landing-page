module Lead.Messages exposing (LeadMsg(..))

import Http


type LeadMsg
    = LeadSubmission (Result Http.Error Bool)
