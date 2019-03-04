import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
  { content : String
  , content2 : String
  }

init : Model
init =
  { content = ""
  , content2 = "" }

-- UPDATE
type Msg
  = FirstString String
  | SecondString String

update : Msg -> Model -> Model
update msg model =
  case msg of
    FirstString newContent ->
      { model | content = newContent }
    SecondString newContent2 ->
      { model | content2 = newContent2 }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ 
    input [ placeholder "First String", value model.content, onInput FirstString ] []
    , input [ placeholder "Second String", value model.content2, onInput SecondString ] []
    , div [] [ text (model.content ++ " : " ++ model.content2) ]
    ]