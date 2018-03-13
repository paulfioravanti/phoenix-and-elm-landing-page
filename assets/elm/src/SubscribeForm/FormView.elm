module SubscribeForm.FormView exposing (view)

import Dict exposing (Dict)
import Html
    exposing
        ( Html
        , button
        , div
        , form
        , h3
        , i
        , input
        , p
        , span
        , text
        )
import Html.Attributes
    exposing
        ( class
        , classList
        , disabled
        , id
        , placeholder
        , required
        , type_
        , value
        )
import Html.Events exposing (onInput, onSubmit)
import Messages
    exposing
        ( Msg
            ( HandleEmailInput
            , HandleFormSubmit
            , HandleFullNameInput
            )
        )
import Model
    exposing
        ( SubscribeForm
            ( Errored
            , Invalid
            , Saving
            )
        , ValidationErrors
        )


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
            , form [ onSubmit HandleFormSubmit ]
                [ div [ class "field" ]
                    [ div [ class "control" ]
                        [ input
                            [ classList
                                [ ( "input is-medium", True )
                                , ( "is-danger", Dict.member "full_name" validationErrors )
                                ]
                            , placeholder "My name is..."
                            , required True
                            , value fullName
                            , onInput HandleFullNameInput
                            ]
                            []
                        , validationErrorView "full_name" validationErrors
                        ]
                    ]
                , div [ class "field" ]
                    [ div [ class "control" ]
                        [ input
                            [ classList
                                [ ( "input is-medium", True )
                                , ( "is-danger", Dict.member "email" validationErrors )
                                ]
                            , type_ "email"
                            , placeholder "My email address is..."
                            , required True
                            , value email
                            , onInput HandleEmailInput
                            ]
                            []
                        , validationErrorView "email" validationErrors
                        ]
                    ]
                , div [ class "field" ]
                    [ div [ id "recaptcha" ]
                        []
                    , validationErrorView "recaptcha_token" validationErrors
                    ]
                , div [ class "field" ]
                    [ div [ class "control" ]
                        [ button
                            [ class "button is-primary is-medium"
                            , disabled buttonDisabled
                            ]
                            [ span [ class "icon" ]
                                [ i
                                    [ classList
                                        [ ( "fa fa-check", not saving )
                                        , ( "fa fa-circle-o-notch fa-spin", saving )
                                        ]
                                    ]
                                    []
                                ]
                            , span []
                                [ text "Subscribe me" ]
                            ]
                        ]
                    ]
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


validationErrorView : String -> ValidationErrors -> Html Msg
validationErrorView key validationErrors =
    case Dict.get key validationErrors of
        Just error ->
            error
                |> List.map text
                |> p [ class "help is-danger" ]

        Nothing ->
            text ""
