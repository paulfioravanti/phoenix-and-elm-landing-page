module SubscribeForm.Utilities
    exposing
        ( extractFormFields
        , extractValidationErrors
        )

import Dict exposing (Dict)
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm
        , SubscribeForm(Editing, Errored, Invalid, Saving, Success)
        , ValidationErrors
        )


extractFormFields : SubscribeForm -> FormFields
extractFormFields subscribeForm =
    case subscribeForm of
        Success ->
            SubscribeForm.Model.emptyFormFields

        Editing formFields ->
            formFields

        Saving formFields ->
            formFields

        Invalid formFields _ ->
            formFields

        Errored formFields _ ->
            formFields


extractValidationErrors : SubscribeForm -> ValidationErrors
extractValidationErrors subscribeForm =
    case subscribeForm of
        Invalid _ validationErrors ->
            validationErrors

        _ ->
            Dict.empty
