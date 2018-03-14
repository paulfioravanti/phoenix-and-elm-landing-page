module Model exposing (Model, initialModel)

import Dict exposing (Dict)
import SubscribeForm.Model exposing (SubscribeForm, SubscribeForm(Editing))


type alias Model =
    { subscribeForm : SubscribeForm }


initialModel : Model
initialModel =
    { subscribeForm = Editing SubscribeForm.Model.emptyFormFields }
