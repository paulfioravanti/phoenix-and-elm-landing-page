module Lead.Encoder exposing (encoder)

import Json.Decode as Decode
import Json.Encode as Encode exposing (object, string)
import Model exposing (FormFields)


encoder : FormFields -> Decode.Value
encoder { fullName, email, recaptchaToken } =
    let
        token =
            Maybe.withDefault "" recaptchaToken
    in
        object
            [ ( "lead"
              , object
                    [ ( "full_name", string fullName )
                    , ( "email", string email )
                    , ( "recaptcha_token", string token )
                    ]
              )
            ]
