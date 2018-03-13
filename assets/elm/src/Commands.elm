module Commands exposing (subscribe)

import Http
import Lead.Request as Request
import Messages exposing (Msg(SubscribeResponse))
import Model exposing (SubscribeForm, SubscribeForm(Saving))


subscribe : SubscribeForm -> Cmd Msg
subscribe subscribeForm =
    case subscribeForm of
        Saving formFields ->
            Http.send SubscribeResponse (Request.submitLead formFields)

        _ ->
            Cmd.none
