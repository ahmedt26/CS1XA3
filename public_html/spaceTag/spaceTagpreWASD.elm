import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url

main : AppWithTick () Model Msg
main = appWithTick Tick
       { init = init
       , update = update
       , view = view
       , subscriptions = subscriptions
       , onUrlRequest = MakeRequest
       , onUrlChange = UrlChange
       }  


type alias Model = { size : Float -- x and ys are coordinate stuff.
  , x : Float
  , y : Float
  , dx : Float
  , dy : Float}

init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url key = ( { size = 10.0 , x = 0.0 , y = 0.0, dx = 0.0 , dy = 0.0 } , Cmd.none )

type Msg = Tick Float GetKeyState
         | MakeRequest Browser.UrlRequest
         | UrlChange Url.Url



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of
       Tick time getKeyState ->
           ( { model | size = model.size}, Cmd.none )

       MakeRequest req ->
           ( model, Cmd.none ) -- do nothing

       UrlChange url ->
           ( model, Cmd.none ) -- do nothing

view : Model -> { title : String, body : Collage Msg }

view model = 
  let 
    title = "Space Tag"
    background = square 100000 |> filled black
    -- location = notifyMouseMoveAt background
    spaceship = group [ circle 20 |> filled white, triangle 20 |> filled blue] 
                      |> rotate (degrees 90) |> move (0, 0)
    badguy = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] 
                   |> rotate (degrees 90) |> move (0, 100)
    body  = collage 1000 1000 [background, spaceship, badguy]
  in { title = title, body = body }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

