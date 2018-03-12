module Update exposing (update)

import Decoders exposing (..)
import Http exposing (Error(..))
import Json.Decode as Decode
import Messages exposing (Msg(..))
import Model exposing (..)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            extractFormFields model.subscribeForm
    in
        case msg of
            HandleFullNameInput value ->
                { model | subscribeForm = Editing { formFields | fullName = value } } ! []

            HandleEmailInput value ->
                { model | subscribeForm = Editing { formFields | email = value } } ! []

            HandleFormSubmit ->
                { model | subscribeForm = Saving formFields } ! []

            SubscribeResponse (Ok result) ->
                { model | subscribeForm = Success } ! []

            SetRecaptchaToken token ->
                { model | subscribeForm = Editing { formFields | recaptchaToken = Just token } } ! []

            SubscribeResponse (Err (BadStatus response)) ->
                case Decode.decodeString validationErrorsDecoder response.body of
                    Ok validationErrors ->
                        { model | subscribeForm = Invalid { formFields | recaptchaToken = Nothing } validationErrors } ! [ Ports.resetRecaptcha () ]

                    Err error ->
                        { model | subscribeForm = Errored { formFields | recaptchaToken = Nothing } "Oops! Something went wrong!" } ! [ Ports.resetRecaptcha () ]

            SubscribeResponse (Err error) ->
                { model | subscribeForm = Errored { formFields | recaptchaToken = Nothing } "Oops! Something went wrong!" } ! [ Ports.resetRecaptcha () ]
