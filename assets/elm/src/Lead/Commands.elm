module Lead.Commands exposing (submitLead)

import Http
import Lead.Messages exposing (LeadMsg(LeadSubmission))
import Lead.Request as Request
import Messages exposing (Msg(LeadMsg))
import SubscribeForm.Model exposing (SubscribeForm, SubscribeForm(Submitting))


submitLead : SubscribeForm -> Cmd Msg
submitLead subscribeForm =
    case subscribeForm of
        Submitting formFields ->
            formFields
                |> Request.submitLead
                |> Http.send LeadSubmission
                |> Cmd.map LeadMsg

        _ ->
            Cmd.none
