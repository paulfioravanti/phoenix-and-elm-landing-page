module SubscribeForm.Fields
    exposing
        ( fullNameField
        , emailField
        , recaptchaField
        , submitButton
        )

import Dict exposing (Dict)
import Html
    exposing
        ( Html
        , button
        , div
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
import Html.Events exposing (onInput)
import Messages exposing (Msg(HandleFullNameInput, HandleEmailInput))
import Model exposing (ValidationErrors)


fullNameField : String -> Dict String (List String) -> Html Msg
fullNameField fullName validationErrors =
    div [ class "field" ]
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


emailField : String -> Dict String (List String) -> Html Msg
emailField email validationErrors =
    div [ class "field" ]
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


recaptchaField : ValidationErrors -> Html Msg
recaptchaField validationErrors =
    div [ class "field" ]
        [ div [ id "recaptcha" ]
            []
        , validationErrorView "recaptcha_token" validationErrors
        ]


submitButton : Bool -> Bool -> Html msg
submitButton saving buttonDisabled =
    div [ class "field" ]
        [ div [ class "control" ]
            [ button
                [ class "button is-primary is-medium", disabled buttonDisabled ]
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


validationErrorView : String -> ValidationErrors -> Html Msg
validationErrorView key validationErrors =
    case Dict.get key validationErrors of
        Just error ->
            error
                |> List.map text
                |> p [ class "help is-danger" ]

        Nothing ->
            text ""