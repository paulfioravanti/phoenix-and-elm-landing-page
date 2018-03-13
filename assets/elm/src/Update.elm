module Update exposing (update)

import Http exposing (Error(..))
import Json.Decode as Decode
import Commands as Commands
import Decoders exposing (validationErrorsDecoder)
import Messages exposing (Msg(..))
import Model exposing (..)
import Recaptcha.Ports
import Recaptcha.Update


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
                ( { model
                    | subscribeForm = Editing { formFields | fullName = value }
                  }
                , Cmd.none
                )

            HandleEmailInput value ->
                ( { model
                    | subscribeForm = Editing { formFields | email = value }
                  }
                , Cmd.none
                )

            HandleFormSubmit ->
                let
                    newSubscribeForm =
                        Saving formFields
                in
                    ( { model
                        | subscribeForm = newSubscribeForm
                      }
                    , Commands.subscribe newSubscribeForm
                    )

            RecaptchaMsg msg ->
                Recaptcha.Update.update msg model subscribeForm formFields

            SubscribeResponse (Ok result) ->
                ( { model | subscribeForm = Success }, Cmd.none )

            SubscribeResponse (Err (BadStatus response)) ->
                case Decode.decodeString validationErrorsDecoder response.body of
                    Ok validationErrors ->
                        ( { model
                            | subscribeForm =
                                Invalid
                                    { formFields | recaptchaToken = Nothing }
                                    validationErrors
                          }
                        , Recaptcha.Ports.resetRecaptcha ()
                        )

                    Err error ->
                        ( { model
                            | subscribeForm =
                                Errored
                                    { formFields | recaptchaToken = Nothing }
                                    "Oops! Something went wrong!"
                          }
                        , Recaptcha.Ports.resetRecaptcha ()
                        )

            SubscribeResponse (Err error) ->
                ( { model
                    | subscribeForm =
                        Errored
                            { formFields | recaptchaToken = Nothing }
                            "Oops! Something went wrong!"
                  }
                , Recaptcha.Ports.resetRecaptcha ()
                )
