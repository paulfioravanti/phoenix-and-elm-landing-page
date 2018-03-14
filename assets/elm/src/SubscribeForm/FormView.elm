module SubscribeForm.FormView exposing (view)

import Html exposing (Html, div, form, h3, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onSubmit)
import Messages exposing (Msg(FormSubmitted))
import Model
import SubscribeForm.Model exposing (SubscribeForm(Errored, Invalid, Saving))
import SubscribeForm.Fields as Fields


view : SubscribeForm -> Html Msg
view subscribeForm =
    let
        { fullName, email, recaptchaToken } =
            Model.extractFormFields subscribeForm

        validationErrors =
            Model.extractValidationErrors subscribeForm

        saving =
            case subscribeForm of
                Saving _ ->
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
                || saving
                || invalid
    in
        div [ class "content" ]
            [ h3 []
                [ text "Want to know more?" ]
            , p []
                [ text "Subscribe to stay updated" ]
            , formError subscribeForm
            , form [ onSubmit FormSubmitted ]
                [ Fields.fullNameField fullName validationErrors
                , Fields.emailField email validationErrors
                , Fields.recaptchaField validationErrors
                , Fields.submitButton saving buttonDisabled
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
