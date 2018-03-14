module SubscribeForm.FormView exposing (view)

import Html exposing (Html, div, form, h3, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onSubmit)
import Messages exposing (Msg(SubscribeFormMsg))
import SubscribeForm.Fields as Fields
import SubscribeForm.Messages exposing (SubscribeFormMsg(FormSubmitted))
import SubscribeForm.Model
    exposing
        ( SubscribeForm(Errored, Invalid, Submitting)
        )
import SubscribeForm.Utilities as Utilities


view : SubscribeForm -> Html Msg
view subscribeForm =
    let
        { fullName, email, recaptchaToken } =
            Utilities.extractFormFields subscribeForm

        validationErrors =
            Utilities.extractValidationErrors subscribeForm

        submitting =
            case subscribeForm of
                Submitting _ ->
                    True

                _ ->
                    False

        invalid =
            case subscribeForm of
                Invalid _ _ ->
                    True

                _ ->
                    False

        buttonDisabled =
            fullName
                == ""
                || email
                == ""
                || recaptchaToken
                == Nothing
                || recaptchaToken
                == Just ""
                || submitting
                || invalid
    in
        div [ class "content" ]
            [ h3 []
                [ text "Want to know more?" ]
            , p []
                [ text "Subscribe to stay updated" ]
            , formError subscribeForm
            , form [ onSubmit (SubscribeFormMsg FormSubmitted) ]
                [ Fields.fullNameField fullName validationErrors
                , Fields.emailField email validationErrors
                , Fields.recaptchaField validationErrors
                , Fields.submitButton submitting buttonDisabled
                ]
            ]


formError : SubscribeForm -> Html Msg
formError subscribeForm =
    case subscribeForm of
        Errored _ message ->
            div [ class "notification is-danger fade-in" ]
                [ text message ]

        _ ->
            text ""
