module Model
    exposing
        ( Model
        , extractFormFields
        , extractValidationErrors
        , initialModel
        )

import Dict exposing (Dict)
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm
        , SubscribeForm(..)
        , ValidationErrors
        )


type alias Model =
    { subscribeForm : SubscribeForm }


extractFormFields : SubscribeForm -> FormFields
extractFormFields subscribeForm =
    case subscribeForm of
        Editing ff ->
            ff

        Saving ff ->
            ff

        Invalid ff _ ->
            ff

        Errored ff _ ->
            ff

        Success ->
            emptyFormFields


emptyFormFields : FormFields
emptyFormFields =
    { fullName = ""
    , email = ""
    , recaptchaToken = Nothing
    }


extractValidationErrors : SubscribeForm -> ValidationErrors
extractValidationErrors subscribeForm =
    case subscribeForm of
        Invalid _ validationErrors ->
            validationErrors

        _ ->
            Dict.empty


initialModel : Model
initialModel =
    { subscribeForm = Editing emptyFormFields }
