module SubscribeForm.Model
    exposing
        ( FormFields
        , SubscribeForm
        , SubscribeForm(..)
        , ValidationErrors
        )

import Dict exposing (Dict)


type alias FormFields =
    { fullName : String
    , email : String
    , recaptchaToken : Maybe String
    }


type alias ValidationErrors =
    Dict String (List String)


type SubscribeForm
    = Editing FormFields
    | Saving FormFields
    | Invalid FormFields ValidationErrors
    | Errored FormFields String
    | Success
