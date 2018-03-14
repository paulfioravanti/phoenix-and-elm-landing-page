module Lead.Update exposing (update)

import Http exposing (Error(BadStatus), Response)
import Json.Decode as Decode
import Lead.Decoder
import Lead.Messages exposing (LeadMsg(LeadSubmission))
import Messages exposing (Msg)
import Model exposing (Model)
import Recaptcha.Ports
import SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm(Errored, Invalid, Success)
        , ValidationErrors
        )


update : LeadMsg -> Model -> FormFields -> ( Model, Cmd Msg )
update msg model formFields =
    case msg of
        LeadSubmission (Ok result) ->
            ( { model | subscribeForm = Success }, Cmd.none )

        LeadSubmission (Err (BadStatus response)) ->
            handleBadStatus model response formFields

        LeadSubmission (Err error) ->
            formErrored model formFields


handleBadStatus : Model -> Response String -> FormFields -> ( Model, Cmd Msg )
handleBadStatus model response formFields =
    let
        validationErrors =
            response
                |> .body
                |> Decode.decodeString Lead.Decoder.errorsDecoder
    in
        case validationErrors of
            Ok errors ->
                formInvalid model formFields errors

            Err error ->
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
