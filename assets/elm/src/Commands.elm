module Commands exposing (subscribe)

import Http
import Lead.Messages exposing (LeadMsg(LeadSubmission))
import Lead.Request as Request
import Messages exposing (Msg(LeadMsg))
import Model exposing (SubscribeForm, SubscribeForm(Saving))


subscribe : SubscribeForm -> Cmd Msg
subscribe subscribeForm =
    case subscribeForm of
        Saving formFields ->
            Http.send LeadSubmission (Request.submitLead formFields)
                |> Cmd.map LeadMsg

        _ ->
            Cmd.none
