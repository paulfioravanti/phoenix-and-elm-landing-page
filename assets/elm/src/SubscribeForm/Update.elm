module SubscribeForm.Update exposing (update)

import Decoders
import Http exposing (Error(BadStatus))
import Json.Decode as Decode
import Lead.Messages exposing (LeadMsg(LeadSubmission))
import Messages exposing (Msg)
import Model
    exposing
        ( Model
        , FormFields
        , SubscribeForm
        , SubscribeForm(Errored, Invalid, Success)
        , ValidationErrors
        )
import Recaptcha.Ports


update : LeadMsg -> Model -> SubscribeForm -> FormFields -> ( Model, Cmd Msg )
update msg model subscribeForm formFields =
    case msg of
        LeadSubmission (Ok result) ->
            ( { model | subscribeForm = Success }, Cmd.none )

        LeadSubmission (Err (BadStatus response)) ->
            let
                validationErrors =
                    response.body
                        |> Decode.decodeString Decoders.validationErrorsDecoder
            in
                case validationErrors of
                    Ok errors ->
                        formInvalid model formFields errors

                    Err error ->
                        formErrored model formFields

        LeadSubmission (Err error) ->
            formErrored model formFields


formInvalid : Model -> FormFields -> ValidationErrors -> ( Model, Cmd Msg )
formInvalid model formFields errors =
    ( { model
        | subscribeForm =
            Invalid { formFields | recaptchaToken = Nothing } errors
      }
    , Recaptcha.Ports.resetRecaptcha ()
    )


formErrored : Model -> FormFields -> ( Model, Cmd Msg )
formErrored model formFields =
    ( { model
        | subscribeForm =
            Errored
                { formFields | recaptchaToken = Nothing }
                "Oops! Something went wrong!"
      }
    , Recaptcha.Ports.resetRecaptcha ()
    )
