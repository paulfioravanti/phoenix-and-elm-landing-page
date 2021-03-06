module SubscribeForm.Utilities
    exposing
        ( extractFormFields
        , extractValidationErrors
        )

import Dict
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm(Editing, Errored, Invalid, Submitting, Success)
        , ValidationErrors
        )


extractFormFields : SubscribeForm -> FormFields
extractFormFields subscribeForm =
    case subscribeForm of
        Success ->
            SubscribeForm.Model.emptyFormFields

        Editing formFields ->
            formFields

        Submitting formFields ->
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
