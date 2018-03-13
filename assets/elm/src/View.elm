module View exposing (view)

import Html exposing (Html)
import Messages exposing (Msg)
import Model exposing (Model, SubscribeForm(Success))
import SubscribeForm.SuccessView
import SubscribeForm.FormView


view : Model -> Html Msg
view { subscribeForm } =
    case subscribeForm of
        Success ->
            SubscribeForm.SuccessView.view

        _ ->
            SubscribeForm.FormView.view subscribeForm
